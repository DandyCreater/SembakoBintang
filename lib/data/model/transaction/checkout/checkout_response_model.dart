import 'package:cloud_firestore/cloud_firestore.dart';

class CheckOutResponseModel {
  final String? id;
  final String? orderId;
  final String? transactionTime;
  final String? transactionDate;
  final String? numberOfItems;
  final String? totalPrice;

  const CheckOutResponseModel(
      {required this.id,
      required this.orderId,
      required this.transactionTime,
      required this.transactionDate,
      required this.numberOfItems,
      required this.totalPrice});

  factory CheckOutResponseModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return CheckOutResponseModel(
        id: doc.id,
        orderId: doc.data()!['orderId'],
        transactionTime: doc.data()!['transactionTime'],
        transactionDate: doc.data()!['trasactionDate'],
        numberOfItems: doc.data()!['numberOfItems'],
        totalPrice: doc.data()!['totalPrice']);
  }
}

class CheckOutParameterPost {
  final String? numberOfItems;
  final String? totalPrice;

  const CheckOutParameterPost(
      {required this.numberOfItems, required this.totalPrice});
}
