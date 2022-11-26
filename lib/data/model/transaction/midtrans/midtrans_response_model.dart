import 'package:sembako_bintang/domain/entity/midtrans/midtrans_entity.dart';

class MidtransResponseModel {
  String? orderId;
  String? paymentUrl;

  MidtransResponseModel({this.orderId, this.paymentUrl});

  MidtransResponseModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    paymentUrl = json['payment_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = orderId;
    data['payment_url'] = paymentUrl;
    return data;
  }

  MidtransEntity toEntity() {
    return MidtransEntity(orderId: orderId, paymentUrl: paymentUrl);
  }
}

class MidtransParameterPost {
  String? orderId;
  int? grossamount;
  String? transactionID;

  MidtransParameterPost(
      {required this.orderId,
      required this.grossamount,
      required this.transactionID});
}

class ItemsParamaterPost {
  String? itemID;
  String? itemName;
  String? itemPrice;
  String? itemQuantity;

  ItemsParamaterPost(
      {required this.itemID,
      required this.itemName,
      required this.itemPrice,
      required this.itemQuantity});

  factory ItemsParamaterPost.fromJson(Map<String, dynamic> json) {
    return ItemsParamaterPost(
        itemID: json['itemsId'],
        itemName: json['productName'],
        itemPrice: json['productPrice'],
        itemQuantity: json['count']);
  }

  Map toMap() {
    return {
      "id": itemID,
      "name": itemName,
      "price": int.tryParse(itemPrice!),
      "quantity": int.tryParse(itemQuantity!),
      "brand": "Midtrans",
      "category": "Other",
      "merchant_name": "PT. Sembako Bintang"
    };
  }
}
