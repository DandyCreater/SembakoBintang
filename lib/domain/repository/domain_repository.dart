import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sembako_bintang/data/model/transaction/cart/cart_responses_model.dart';
import 'package:sembako_bintang/data/model/transaction/checkout/checkout_response_model.dart';
import 'package:sembako_bintang/data/utils/helper/failure.dart';
import 'package:sembako_bintang/domain/entity/items/items_entity.dart';
import 'package:sembako_bintang/domain/entity/transaction/barang/barang_entity.dart';
import 'package:sembako_bintang/domain/entity/transaction/cart/cart_entity.dart';
import 'package:sembako_bintang/domain/entity/transaction/data-transaction/data_transaction_entity.dart';

import '../entity/dashboard/menu_entity.dart';

abstract class DomainRepository {
  //Dashboard
  Future<Either<ServerFailure, MenuDashboardEntity>> fetchMenuDashboard();

  //Items
  Future<Either<ServerFailure, String>> tambahBarang(
    String price,
    String productName,
    File imageFile,
  );
  Future<Either<ServerFailure, List<ItemsEntity>>> getItemData();
  Future<Either<ServerFailure, List<ItemsEntity>>> filterItem(String itemName);
  Future<Either<ServerFailure, String>> deleteItem(String itemsId);
  Future<Either<ServerFailure, String>> updateItem(
      ItemsEntity dataItem, File? imageFile);

  //Transaction
  Future<Either<ServerFailure, String>> deleteItemAtCart(
      String itemsId, bool addCart);
  Future<Either<ServerFailure, String>> addItemToCart(
      CartParamaterPost value, bool addCart, String itemsId);
  Future<Either<ServerFailure, List<CartEntity>>> getItemCart();
  Future<Either<ServerFailure, String>> deleteItemCheckOutCart(
      String id, String itemsId);
  Future<Either<ServerFailure, String>> updateCartData(
      CartParamaterPost value, String itemsId);
  Future<Either<ServerFailure, String>> checkOutData(
      CheckOutParameterPost value);
  Future<Either<ServerFailure, String>> clearCartItems();
  Future<Either<ServerFailure, List<DataTransactionEntity>>>
      getDataTransaction();

  //Reports
  Future<Either<ServerFailure, List<DataTransactionEntity>>> filterItemByDate(
      DateTime startDate, DateTime endDate);
}
