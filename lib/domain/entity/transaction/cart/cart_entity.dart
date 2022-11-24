// class CartEntity {
//   String? responseCode;
//   OKContentCartEntity? oKContentCart;

//   CartEntity({required this.responseCode, required this.oKContentCart});
// }

// class OKContentCartEntity {
//   List<ListCart>? cart;

//   OKContentCartEntity({required this.cart});

//   OKContentCartEntity.fromJson(Map<String, dynamic> json) {
//     if (json['cart'] != null) {
//       cart = <ListCart>[];
//       json['cart'].forEach((v) {
//         cart!.add(new ListCart.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.cart != null) {
//       data['cart'] = this.cart!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class ListCart {
//   String? imageUrl;
//   String? title;
//   String? price;
//   String? count;

//   ListCart(
//       {required this.imageUrl,
//       required this.title,
//       required this.price,
//       required this.count});

//   ListCart.fromJson(Map<String, dynamic> json) {
//     imageUrl = json['imageUrl'];
//     title = json['title'];
//     price = json['price'];
//     count = json['count'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['imageUrl'] = this.imageUrl;
//     data['title'] = this.title;
//     data['price'] = this.price;
//     data['count'] = this.count;
//     return data;
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class CartEntity {
  final String? id;
  final String? cartId;
  final String? imageItem;
  final String? productName;
  final String? productPrice;
  final String? count;
  final String? finalPrice;

  const CartEntity(
      {required this.id,
      required this.productName,
      required this.imageItem,
      required this.productPrice,
      required this.count,
      required this.finalPrice,
      required this.cartId});

  factory CartEntity.fromJson(DocumentSnapshot<Map<String, dynamic>> doc) {
    return CartEntity(
      id: doc.id,
      imageItem: doc.data()!['imageItem'],
      cartId: doc.data()!['itemsId'],
      productName: doc.data()!['productName'],
      productPrice: doc.data()!['productPrice'],
      count: doc.data()!['count'],
      finalPrice: doc.data()!['finalPrice'],
    );
  }
}
