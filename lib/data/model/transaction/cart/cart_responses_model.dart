// ignore_for_file: unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sembako_bintang/domain/entity/transaction/cart/cart_entity.dart';

class CartResponseModel {
  final String? id;
  final String? cartId;
  final String? imageItem;
  final String? productName;
  final String? productPrice;
  String? finalPrice;
  String? count;

  CartResponseModel(
      {this.finalPrice,
      this.imageItem,
      this.id,
      this.productName,
      this.productPrice,
      this.count,
      this.cartId});

  factory CartResponseModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return CartResponseModel(
        id: doc.id,
        imageItem: doc.data()!['imageItem'],
        cartId: doc.data()!['itemsId'],
        productName: doc.data()!['productName'],
        productPrice: doc.data()!['productPrice'],
        count: doc.data()!['count'],
        finalPrice: doc.data()!['finalPrice']);
  }

  Map toMap() {
    return {
      'count': count,
      'finalPrice': finalPrice,
      'imageItem': imageItem,
      'itemsId': cartId,
      'productName': productName,
      'productPrice': productPrice,
    };
  }

  CartEntity toEntity() {
    return CartEntity(
        id: this.id,
        productName: this.productName,
        productPrice: this.productPrice,
        count: this.count,
        cartId: this.cartId,
        imageItem: this.imageItem,
        finalPrice: this.finalPrice);
  }
}

class CartParamaterPost {
  final String? imageItem;
  final String? itemsId;
  final String? productName;
  final String? productPrice;
  final String? count;
  final String? priceTotal;

  const CartParamaterPost(
      {required this.priceTotal,
      required this.imageItem,
      required this.itemsId,
      required this.productName,
      required this.productPrice,
      required this.count});
}
