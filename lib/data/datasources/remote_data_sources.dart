// ignore_for_file: unused_field, unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:sembako_bintang/data/model/items/items_response_model.dart';
import 'package:sembako_bintang/data/model/transaction/cart/cart_responses_model.dart';
import 'package:sembako_bintang/data/model/transaction/checkout/checkout_response_model.dart';
import 'package:sembako_bintang/data/model/transaction/data-transaction/data_transaction_response_model.dart';
import 'package:sembako_bintang/data/model/transaction/midtrans/midtrans_response_model.dart';
import 'package:sembako_bintang/domain/entity/items/items_entity.dart';

abstract class RemoteDataSources {
  //Item Area
  Future getItem();

  //Items Area
  Future tambahBarang(String price, String productName, File imageFile);
  Future searchItem(String itemName);
  Future deleteItem(String itemsId);
  Future editItem(ItemsEntity dataItem, File imageFile);

  //Transaction Area
  Future addToCart(CartParamaterPost value, bool addCart, String itemsId);
  Future deleteItemAtCart(String itemsId, bool addCart);
  Future getCartItem();
  Future deleteItemCheckOutCart(String id, String itemsId);
  Future updateCartItem(CartParamaterPost value, String itemsId);
  Future checkOutItem(CheckOutParameterPost value);
  Future clearCartItem();
  Future getTransactionData();
  Future generateMidTrans();
  Future cancelTransactionPayment(String itemsId);
  Future finishTransactionPayment(String itemsId);

  //Reports Area
  Future filterDatabyDate(DateTime startDate, DateTime endDate);
}

class RemoteDataSourcesImpl implements RemoteDataSources {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storage = const FlutterSecureStorage();

  //Items Area
  //Get Data and Filter
  @override
  Future getItem() async {
    try {
      QuerySnapshot<Map<String, dynamic>> dataItem =
          await firestore.collection('items').get();

      final allData =
          dataItem.docs.map((e) => ItemsResponseModel.fromJson(e)).toList();

      return allData;
    } catch (e) {
      debugPrint("Error Data Sources Get Item $e");
    }
  }

  @override
  Future searchItem(String itemName) async {
    List<ItemsResponseModel> filterResult = [];
    try {
      QuerySnapshot<Map<String, dynamic>> dataItem =
          await firestore.collection('items').get();

      final allData =
          dataItem.docs.map((e) => ItemsResponseModel.fromJson(e)).toList();
      var check = allData
          .where((element) =>
              element.productName!.toLowerCase().contains(itemName))
          .toList();

      for (var items in check) {
        filterResult.add(items);
      }
      return filterResult;
    } catch (e) {
      debugPrint("Error Data Sources Get Item $e");
    }
  }

  //Input And Update
  @override
  Future tambahBarang(String price, String productName, File imageFile) async {
    String imageUrl = '';
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('items');
    Reference storage = FirebaseStorage.instance.ref();
    var date = DateTime.now();

    try {
      TaskSnapshot snapshot = await storage
          .child(
              "images/img/$productName-${date.day}-${date.hour}-${date.minute}-${date.second}")
          .putFile(imageFile);

      if (snapshot.state == TaskState.success) {
        imageUrl = await snapshot.ref.getDownloadURL();
      }

      //Data Area
      var data = {
        'price': price,
        'productImage': imageUrl,
        'productName': productName,
        'selected': false,
        'addCart': false,
      };

      await collectionReference.add(data);

      return "OK";
    } catch (e) {
      debugPrint("Error Tambah Barang Data Source : $e");
      return e;
    }
  }

  //Delete and Edit
  @override
  Future deleteItem(String itemsId) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('items');

    String result = 'fail';

    try {
      collectionReference.doc(itemsId).delete();

      result = "OK";
      return result;
    } catch (e) {
      debugPrint("Delete Item Data Failed $e");
      return e;
    }
  }

  @override
  Future editItem(ItemsEntity dataItem, File? imageFile) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('items');
    Reference storage = FirebaseStorage.instance.ref();
    var date = DateTime.now();
    String imageUrl = '';
    try {
      String imageString = imageFile.toString();
      if (imageString != "File: ''") {
        TaskSnapshot snapshot = await storage
            .child(
                "images/img/${dataItem.productName}-${date.day}-${date.hour}-${date.minute}-${date.second}")
            .putFile(imageFile!);

        if (snapshot.state == TaskState.success) {
          imageUrl = await snapshot.ref.getDownloadURL();
        }
      } else {
        imageUrl = dataItem.productImage!;
      }

      var data = {
        'price': dataItem.price,
        'productImage': imageUrl,
        'productName': dataItem.productName,
        'selected': false,
        'addCart': false,
      };
      collectionReference.doc(dataItem.id).update(data);
      return "OK";
    } catch (e) {
      debugPrint("Update Item Failed $e");
      return e;
    }
  }

  //Transaction Area

  //Add and Delete Item
  @override
  Future addToCart(
      CartParamaterPost value, bool addCart, String itemsId) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('cart');
    CollectionReference collectionReference2 =
        FirebaseFirestore.instance.collection('items');

    var priceInt = int.tryParse(value.productPrice!);
    var countInt = int.tryParse(value.count!);
    var finalPrice = (priceInt! * countInt!);

    try {
      var data = {
        'itemsId': value.itemsId,
        'count': value.count,
        'productName': value.productName,
        'productPrice': value.productPrice,
        'imageItem': value.imageItem,
        'finalPrice': finalPrice.toString(),
      };

      var itemsdata = {
        'addCart': addCart,
      };

      await collectionReference.add(data);
      await collectionReference2.doc(itemsId).update(itemsdata);

      return "OK";
    } catch (e) {
      debugPrint("Add To Cart Error $e");
      return e;
    }
  }

  @override
  Future deleteItemAtCart(String itemsId, bool addCart) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('cart');
    CollectionReference collectionReference2 =
        FirebaseFirestore.instance.collection('items');

    String result = 'fail';
    QuerySnapshot<Map<String, dynamic>> dataItem =
        await firestore.collection('cart').get();
    List<CartResponseModel> deleteItemList = [];
    try {
      final allData =
          dataItem.docs.map((e) => CartResponseModel.fromJson(e)).toList();

      var check = allData
          .where((element) => element.cartId!.contains(itemsId))
          .toList();

      for (var items in check) {
        deleteItemList.add(items);
      }

      var doubleCheck = deleteItemList
          .where((element) => element.cartId!.contains(itemsId))
          .toList();

      var itemsdata = {
        'addCart': addCart,
      };

      await collectionReference.doc(doubleCheck.first.id).delete();
      await collectionReference2.doc(itemsId).update(itemsdata);

      result = "OK";
      return result;
    } catch (e) {
      debugPrint("Delete Item Data Failed $e");
      return e;
    }
  }

  @override
  Future getCartItem() async {
    QuerySnapshot<Map<String, dynamic>> dataItem =
        await firestore.collection('cart').get();

    try {
      final allData =
          dataItem.docs.map((e) => CartResponseModel.fromJson(e)).toList();

      return allData;
    } catch (e) {
      debugPrint("Get Data Cart Error $e");
    }
  }

  //CheckOut Cart
  @override
  Future deleteItemCheckOutCart(String id, String itemsId) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('cart');
    CollectionReference collectionReference2 =
        FirebaseFirestore.instance.collection('items');

    String result = 'fail';

    try {
      var itemsdata = {
        'addCart': false,
      };

      await collectionReference.doc(id).delete();
      await collectionReference2.doc(itemsId).update(itemsdata);

      result = "OK";
      return result;
    } catch (e) {
      debugPrint("Delete Item Check Out Cart Failed $e");
      return e;
    }
  }

  @override
  Future updateCartItem(CartParamaterPost value, String itemsId) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('cart');
    String result = 'fail';
    try {
      var data = {
        'count': value.count,
        'finalPrice': value.priceTotal,
      };

      await collectionReference.doc(itemsId).update(data);

      result = "OK";
      return result;
    } catch (e) {
      debugPrint("Update Item Cart Item Failed $e");
      return e;
    }
  }

  //Transaction CheckOut
  @override
  Future checkOutItem(CheckOutParameterPost value) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('transaction');
    QuerySnapshot<Map<String, dynamic>> dataItem =
        await firestore.collection('cart').get();
    QuerySnapshot<Map<String, dynamic>> dataTransactionItem =
        await firestore.collection('transaction').get();

    String result = 'fail';
    String orderId = '';
    var randomNum = Random();
    var randomNum2 = Random();
    try {
      var dateFormatted =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(DateTime.now());
      DateTime dateTime = DateTime.now();
      String dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
      String timeFormat = DateFormat('HH:mm').format(dateTime);

      List<DataTransactionResponseModel>? allData = dataTransactionItem.docs
          .map((e) => DataTransactionResponseModel.fromJson(e))
          .toList();

      var dataCart =
          dataItem.docs.map((e) => CartResponseModel.fromJson(e)).toList();

      for (var i = 0; i < allData.length; i++) {
        debugPrint(allData[i].transactionDate.toString());
      }

      allData.sort((a, b) {
        int aDate =
            DateTime.parse(a.transactionDate ?? '').microsecondsSinceEpoch;
        int bDate =
            DateTime.parse(b.transactionDate ?? '').microsecondsSinceEpoch;
        return aDate.compareTo(bDate);
      });

      if (allData.last.orderId == null) {
        orderId = "1";
      } else {
        var orderIdInt = int.tryParse(allData.last.orderId!);
        var orderIdCount = orderIdInt! + 1;
        orderId = orderIdCount.toString();
      }

      var data = {
        'orderId': orderId,
        'transactionTime': timeFormat,
        'transactionDate': dateFormat,
        'numberOfItems': value.numberOfItems,
        'totalPrice': value.totalPrice,
        'status': 'Unpaid',
        'midTransCode':
            'sembakobintangs${randomNum.nextInt(1000)}${randomNum2.nextInt(50)}',
        'dateFormatMidtrans': '$dateFormatted',
        'data': dataCart.map((e) => e.toMap()).toList(),
      };

      storage.write(
        key: 'transactionKey',
        value: jsonEncode(data),
        aOptions: AndroidOptions.defaultOptions,
      );
      await collectionReference.add(data);
      result = "OK";
      return result;
    } catch (e) {
      debugPrint("check Out Item Error $e ");
    }
  }

  @override
  Future clearCartItem() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('items');
    QuerySnapshot<Map<String, dynamic>> dataItem =
        await firestore.collection('items').get();
    QuerySnapshot<Map<String, dynamic>> cartItem =
        await firestore.collection('cart').get();
    String result = 'fail';
    try {
      final allData =
          dataItem.docs.map((e) => ItemsResponseModel.fromJson(e)).toList();

      var data = {
        'addCart': false,
      };
      for (var items in allData) {
        await collectionReference.doc(items.id).update(data);
      }

      for (var items in cartItem.docs) {
        await items.reference.delete();
      }
      result = 'OK';
      return result;
    } catch (e) {
      debugPrint("Clear Cart Item Error $e");
      return e;
    }
  }

  @override
  Future cancelTransactionPayment(String itemsId) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('transaction');
    String? result = 'fail';
    try {
      await collectionReference.doc(itemsId).delete();
      result = "OK";
      return result;
    } catch (e) {
      debugPrint("Cancel Transaction Error $e");
    }
  }

  @override
  Future finishTransactionPayment(String itemsId) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('transaction');
    String? result = 'fail';
    try {

      var data = {
        'status' : 'Paid'
      };

      await collectionReference.doc(itemsId).update(data);
      result = "OK";
      return result;
    } catch (e) {
      debugPrint("Finish Transaction Error $e");
    }
  }

  @override
  Future getTransactionData() async {
    QuerySnapshot<Map<String, dynamic>>? dataItem =
        await firestore.collection('transaction').get();
    QuerySnapshot<Map<String, dynamic>>? dataUpdate =
        await firestore.collection('transaction').get();
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('transaction');

    try {
      final allData = dataItem.docs
          .map((e) => DataTransactionResponseModel.fromJson(e))
          .toList();

      return allData;
    } catch (e) {
      debugPrint("Get Transaction Data Error $e");
      return e;
    }
  }

  @override
  Future generateMidTrans() async {
    Dio dio = Dio();

    try {
      var dateFormatted =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(DateTime.now());
      String baseUrl = 'https://api.sandbox.midtrans.com/v1/payment-links';
      String serverKey = 'SB-Mid-server-ibfdMYRRgJQDz05rw2isTi1E';
      String serverData = base64.encode(serverKey.codeUnits);

      String? data = await storage.read(
          key: 'transactionKey', aOptions: AndroidOptions.defaultOptions);
      final jsonData = jsonDecode(data!);

      List listItemTransaction = await jsonData['data']
          .map((e) => ItemsParamaterPost.fromJson(e))
          .toList();

      var envelope = {
        "transaction_details": {
          "order_id": jsonData['midTransCode'],
          "gross_amount": int.tryParse(jsonData['totalPrice']),
          "payment_link_id": "for-${jsonData['midTransCode']}"
        },
        "credit_card": {"secure": true},
        "usage_limit": 1,
        "expiry": {
          "start_time": "${jsonData['dateFormatMidtrans']}",
          "duration": 20,
          "unit": "days"
        },
        "enabled_payments": ["credit_card", "bca_va", "indomaret"],
        "item_details": listItemTransaction.map((e) => e.toMap()).toList(),
        "customer_details": {
          "first_name": "Michael",
          "last_name": "Julian",
          "email": "michael.julian@gmail.com",
          "phone": "+62181128473821",
          "notes":
              "Thank you for your purchase. Please follow the instructions to pay."
        },
        "custom_field1": jsonData['midTransCode'],
        "custom_field2": "",
        "custom_field3": ""
      };

      var response = await dio.post(
        baseUrl,
        options: Options(headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Basic $serverData',
        }),
        data: envelope,
      );

      if (response.statusCode == 200) {
        var result = MidtransResponseModel.fromJson(response.data);
        debugPrint(response.data.toString());

        return result;
      } else {
        debugPrint(response.toString());
      }
    } catch (e) {
      debugPrint("Generate MidTrans Error $e");
      return e;
    }
  }

  //Reports Area
  @override
  Future filterDatabyDate(DateTime startDate, DateTime endDate) async {
    QuerySnapshot<Map<String, dynamic>> dataTransactionItem =
        await firestore.collection('transaction').get();

    try {
      final allData = dataTransactionItem.docs
          .map((e) => DataTransactionResponseModel.fromJson(e))
          .toList();
      var output = <DataTransactionResponseModel>[];
      var dateFormat = DateFormat('y-MM-dd');
      for (var i = 0; i < allData.length; i += 1) {
        var date = dateFormat.parse(
            allData[i].transactionDate!.substring(0, 10), true);
        if (date.compareTo(startDate) >= 0 && date.compareTo(endDate) <= 0) {
          output.add(allData[i]);
        }
      }

      return output;
    } catch (e) {
      debugPrint("Filter Data by Date Error $e");
      return e;
    }
  }
}
