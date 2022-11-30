// ignore_for_file: unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sembako_bintang/domain/entity/transaction/data-transaction/data_transaction_entity.dart';

class DataTransactionResponseModel {
  final String? id;
  final String? orderId;
  final String? transactionTime;
  final String? transactionDate;
  final String? numberOfItems;
  final String? totalPrice;
  final String? midTransCode;
  final String? status;
  final String? dateFormatMidtrans;
  final List<dynamic> data;

  const DataTransactionResponseModel(
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

  factory DataTransactionResponseModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return DataTransactionResponseModel(
      id: doc.id,
      orderId: doc.data()!['orderId'],
      transactionTime: doc.data()!['transactionTime'],
      midTransCode: doc.data()!['midTransCode'],
      transactionDate: doc.data()!['transactionDate'],
      numberOfItems: doc.data()!['numberOfItems'],
      totalPrice: doc.data()!['totalPrice'],
      status: doc.data()!['status'],
      data: doc.data()!['data'],
      dateFormatMidtrans: doc.data()!['dateFormatMidtrans'],
    );
  }

  DataTransactionEntity toEntity() {
    return DataTransactionEntity(
        id: this.id,
        orderId: this.orderId,
        transactionTime: this.transactionTime,
        transactionDate: this.transactionDate,
        numberOfItems: this.numberOfItems,
        totalPrice: this.totalPrice,
        data: this.data,
        status: this.status,
        midTransCode: this.midTransCode,
        dateFormatMidtrans: this.dateFormatMidtrans);
  }
}
