// ignore_for_file: unnecessary_this

import 'package:sembako_bintang/domain/entity/transaction/cart/cart_entity.dart';

class CartResponseModel {
  String? responseCode;
  OKContentCart? oKContentCart;

  CartResponseModel({this.responseCode, this.oKContentCart});

  CartResponseModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    oKContentCart = json['OKContentCart'] != null
        ? new OKContentCart.fromJson(json['OKContentCart'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    if (this.oKContentCart != null) {
      data['OKContentCart'] = this.oKContentCart!.toJson();
    }
    return data;
  }

  CartEntity toEntity() {
    return CartEntity(
        responseCode: this.responseCode,
        oKContentCart:
            this.oKContentCart != null ? this.oKContentCart!.toEntity() : null);
  }
}

class OKContentCart {
  List<Cart>? cart;

  OKContentCart({this.cart});

  OKContentCart.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  OKContentCartEntity toEntity() {
    return OKContentCartEntity(
        cart: this.cart != null
            ? this.cart!.map((e) => e.toEntity()).toList()
            : null);
  }
}

class Cart {
  String? imageUrl;
  String? title;
  String? price;
  String? count;

  Cart({this.imageUrl, this.title, this.price, this.count});

  Cart.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    title = json['title'];
    price = json['price'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['title'] = this.title;
    data['price'] = this.price;
    data['count'] = this.count;
    return data;
  }

  ListCart toEntity() {
    return ListCart(
        imageUrl: this.imageUrl,
        title: this.title,
        price: this.price,
        count: this.count);
  }
}
