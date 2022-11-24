import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsEntity {
  final String? id;
  bool? addCart;
  final String? productImage;
  final String? price;
  final String? productName;
  bool? selected;

  ItemsEntity(
      {required this.id,
      required this.addCart,
      required this.productName,
      required this.price,
      required this.productImage,
      required this.selected});

  factory ItemsEntity.fromJson(DocumentSnapshot<Map<String, dynamic>> doc) {
    return ItemsEntity(
      id: doc.id,
      addCart: doc.data()!['addCart'],
      productName: doc.data()!['productName'],
      price: doc.data()!['price'],
      selected: doc.data()!['selected'],
      productImage: doc.data()!['productImage'],
    );
  }
}
