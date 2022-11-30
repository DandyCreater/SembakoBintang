import 'package:cloud_firestore/cloud_firestore.dart';

class DataTransactionEntity {
  final String? id;
  final String? orderId;
  final String? transactionTime;
  final String? transactionDate;
  final String? numberOfItems;
  final String? totalPrice;
  final String? midTransCode;
  final String? dateFormatMidtrans;
  final String? status;
  final List<dynamic> data;

  const DataTransactionEntity(
      {required this.id,
      required this.orderId,
      required this.transactionTime,
      required this.transactionDate,
      required this.numberOfItems,
      required this.totalPrice,
      required this.midTransCode,
      required this.dateFormatMidtrans,
      required this.status,
      required this.data});

  factory DataTransactionEntity.fromJson(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return DataTransactionEntity(
      id: doc.id,
      orderId: doc.data()!['orderId'],
      transactionTime: doc.data()!['transactionTime'],
      transactionDate: doc.data()!['transactionDate'],
      numberOfItems: doc.data()!['numberOfItems'],
      totalPrice: doc.data()!['totalPrice'],
      midTransCode: doc.data()!['midTransCode'],
      status: doc.data()!['status'],
      data: doc.data()!['data'], dateFormatMidtrans: doc.data()!['dateFormatMidtrans'],
    );
  }
}
