// ignore_for_file: unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sembako_bintang/domain/entity/items/items_entity.dart';

class ItemsResponseModel {
  final String? id;
  final bool? addCart;
  final String? productImage;
  final String? price;
  final String? productName;
  final bool? selected;

  const ItemsResponseModel(
      {this.id,
      this.addCart,
      this.productName,
      this.price,
      this.productImage,
      this.selected});

  factory ItemsResponseModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return ItemsResponseModel(
      id: doc.id,
      addCart: doc.data()!['addCart'],
      productName: doc.data()!['productName'],
      price: doc.data()!['price'],
      selected: doc.data()!['selected'],
      productImage: doc.data()!['productImage'],
    );
  }
  ItemsEntity toEntity() {
    return ItemsEntity(
        productName: this.productName,
        price: this.price,
        productImage: this.productImage,
        selected: this.selected,
        id: this.id, addCart: this.addCart);
  }
}
