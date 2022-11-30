import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sembako_bintang/data/datasources/local_data_sources.dart';
import 'package:sembako_bintang/data/datasources/remote_data_sources.dart';
import 'package:sembako_bintang/data/model/dashboard/menu_response_model.dart';
import 'package:sembako_bintang/data/model/items/items_response_model.dart';
import 'package:sembako_bintang/data/model/transaction/barang/barang_response_model.dart';
import 'package:sembako_bintang/data/model/transaction/cart/cart_responses_model.dart';
import 'package:sembako_bintang/data/model/transaction/checkout/checkout_response_model.dart';
import 'package:sembako_bintang/data/model/transaction/data-transaction/data_transaction_response_model.dart';
import 'package:sembako_bintang/data/utils/helper/failure.dart';
import 'package:sembako_bintang/domain/entity/dashboard/menu_entity.dart';
import 'package:sembako_bintang/domain/entity/items/items_entity.dart';
import 'package:sembako_bintang/domain/entity/midtrans/midtrans_entity.dart';
import 'package:sembako_bintang/domain/entity/transaction/barang/barang_entity.dart';
import 'package:sembako_bintang/domain/entity/transaction/cart/cart_entity.dart';
import 'package:sembako_bintang/domain/entity/transaction/data-transaction/data_transaction_entity.dart';
import 'package:sembako_bintang/domain/repository/domain_repository.dart';
import 'package:sembako_bintang/presentation/bloc/checkout-bloc/checkout_item_bloc.dart';

import '../model/transaction/midtrans/midtrans_response_model.dart';

class DataRepositoryImpl extends DomainRepository {
  final LocalDataSources localDataSources;
  final RemoteDataSources remoteDataSources;

  DataRepositoryImpl(
      {required this.localDataSources, required this.remoteDataSources});

  //Menu Dashboard Area
  @override
  Future<Either<ServerFailure, MenuDashboardEntity>>
      fetchMenuDashboard() async {
    try {
      MenuResponseModel result = await localDataSources.fetchMenuDashboard();

      if (result.responseCode == "OK") {
        return right(result.toEntity());
      } else {
        return left(ServerFailure("Fetch Menu Error!"));
      }
    } catch (e) {
      return Left(ServerFailure("CATCH ERROR REPOSITORY MENU $e"));
    }
  }

  //Items Area
  @override
  Future<Either<ServerFailure, String>> tambahBarang(
    String price,
    String productName,
    File imageFile,
  ) async {
    try {
      String result =
          await remoteDataSources.tambahBarang(price, productName, imageFile);
      if (result == "OK") {
        return right(result);
      } else {
        return left(ServerFailure("Tambah Barang Error"));
      }
    } catch (e) {
      return Left(
          ServerFailure("Catch Error Tambah Barang Data Repository $e"));
    }
  }

  @override
  Future<Either<ServerFailure, List<ItemsEntity>>> getItemData() async {
    try {
      List<ItemsResponseModel> result = await remoteDataSources.getItem();
      List<ItemsEntity> resultEntity = [];
      for (var items in result) {
        resultEntity.add(items.toEntity());
      }
      if (result != null) {
        return right(resultEntity);
      } else {
        return left(ServerFailure("Get Item Data Error"));
      }
    } catch (e) {
      return Left(ServerFailure("Catch Error Item Get Item Data Error $e"));
    }
  }

  @override
  Future<Either<ServerFailure, List<ItemsEntity>>> filterItem(
      String itemName) async {
    try {
      List<ItemsResponseModel> result =
          await remoteDataSources.searchItem(itemName);
      List<ItemsEntity> resultEntity = [];
      for (var items in result) {
        resultEntity.add(items.toEntity());
      }
      if (result != null) {
        return right(resultEntity);
      } else {
        return left(ServerFailure("Search Item Error"));
      }
    } catch (e) {
      return Left(ServerFailure("Catch Filter Data Search Data Error $e"));
    }
  }

  @override
  Future<Either<ServerFailure, String>> deleteItem(String itemsId) async {
    try {
      String result = await remoteDataSources.deleteItem(itemsId);
      if (result == "OK") {
        return right(result);
      } else {
        return left(ServerFailure("Delete Item Failed"));
      }
    } catch (e) {
      return Left(ServerFailure("Catch Detele Item Data Repository $e"));
    }
  }

  @override
  Future<Either<ServerFailure, String>> updateItem(
      ItemsEntity dataItem, File? imageFile) async {
    try {
      String result = await remoteDataSources.editItem(dataItem, imageFile!);
      if (result == "OK") {
        return right(result);
      } else {
        return left(ServerFailure("Update Item Failed"));
      }
    } catch (e) {
      return Left(ServerFailure("Catch Update Item Data Repository $e"));
    }
  }

//Transaction Area
  @override
  Future<Either<ServerFailure, String>> addItemToCart(
      CartParamaterPost value, bool addCart, String itemsId) async {
    try {
      String result =
          await remoteDataSources.addToCart(value, addCart, itemsId);

      if (result == "OK") {
        return right(result);
      } else {
        return left(ServerFailure("Add Item to Cart Failed"));
      }
    } catch (e) {
      return Left(ServerFailure("Catch Add Item to Card Data Repository $e"));
    }
  }

  @override
  Future<Either<ServerFailure, String>> deleteItemAtCart(
      String itemsId, bool addCart) async {
    try {
      String result =
          await remoteDataSources.deleteItemAtCart(itemsId, addCart);
      if (result == "OK") {
        return right(result);
      } else {
        return left(ServerFailure("Delete Item At Cart Failed"));
      }
    } catch (e) {
      return Left(ServerFailure("Delete Item At Card Data Repository $e"));
    }
  }

  @override
  Future<Either<ServerFailure, List<CartEntity>>> getItemCart() async {
    try {
      List<CartResponseModel> result = await remoteDataSources.getCartItem();
      List<CartEntity> resultEntity = [];
      for (var items in result) {
        resultEntity.add(items.toEntity());
      }
      if (result != null) {
        return right(resultEntity);
      } else {
        return left(ServerFailure("Get Item Cart Error "));
      }
    } catch (e) {
      return Left(
          ServerFailure("Catch Get Item Cart Error Data Repository $e"));
    }
  }

  @override
  Future<Either<ServerFailure, String>> deleteItemCheckOutCart(
      String id, String itemsId) async {
    try {
      String result =
          await remoteDataSources.deleteItemCheckOutCart(id, itemsId);
      if (result == "OK") {
        return right(result);
      } else {
        return left(
            ServerFailure("Delete Item Check Out Cart Data Repository Error"));
      }
    } catch (e) {
      return Left(
          ServerFailure("Delete Item Check Out Cart Data Repository Error $e"));
    }
  }

  @override
  Future<Either<ServerFailure, String>> updateCartData(
      CartParamaterPost value, String itemsId) async {
    try {
      String result = await remoteDataSources.updateCartItem(value, itemsId);
      if (result == "OK") {
        return right(result);
      } else {
        return left(ServerFailure("Update Cart Data Failed Data Repository"));
      }
    } catch (e) {
      return Left(ServerFailure("Update Cart Data Failed Data Reposistory $e"));
    }
  }

  @override
  Future<Either<ServerFailure, String>> checkOutData(
      CheckOutParameterPost value) async {
    try {
      String result = await remoteDataSources.checkOutItem(value);
      if (result == "OK") {
        return right(result);
      } else {
        return left(ServerFailure("CheckOutData Error Data Repository"));
      }
    } catch (e) {
      return Left(ServerFailure("CheckOutData Error Data Repository $e"));
    }
  }

  @override
  Future<Either<ServerFailure, String>> clearCartItems() async {
    try {
      String result = await remoteDataSources.clearCartItem();
      if (result == "OK") {
        return right(result);
      } else {
        return left(ServerFailure("Clear Cart Items Error"));
      }
    } catch (e) {
      return Left(
          ServerFailure("Catch Clear Cart Items Error Data Repository $e"));
    }
  }

  @override
  Future<Either<ServerFailure, MidtransEntity>> midTransGenerate() async {
    try {
      MidtransResponseModel result = await remoteDataSources.generateMidTrans();
      if (result != null) {
        return right(result.toEntity());
      } else {
        return left(ServerFailure("Generate MidTrans Error"));
      }
    } catch (e) {
      debugPrint("Generate MidTrans Error Data Repository $e");
      return Left(ServerFailure("Generate MidTrans Error Data Repository $e"));
    }
  }

  @override
  Future<Either<ServerFailure, String>> cancelTransactionPayment(
      String itemsId) async {
    try {
      String result = await remoteDataSources.cancelTransactionPayment(itemsId);
      if (result == "OK") {
        return right(result);
      }
      return left(ServerFailure("Cancel Transaction Failed"));
    } catch (e) {
      debugPrint("Cancel Transaction Error Data Repository $e");
      return Left(ServerFailure('Cancel Transaction Error Data Repository $e'));
    }
  }

  @override
  Future<Either<ServerFailure, String>> finishTransactionPayment(
      String itemsId) async {
    try {
      String result = await remoteDataSources.finishTransactionPayment(itemsId);
      if (result == "OK") {
        return right(result);
      } else {
        return left(ServerFailure("Finish Transaction Failed"));
      }
    } catch (e) {
      debugPrint("Finish Transaction Error Data Repository $e");
      return Left(ServerFailure("Finish Transaction Error Data Repository $e"));
    }
  }

  @override
  Future<Either<ServerFailure, List<DataTransactionEntity>>>
      getDataTransaction() async {
    try {
      List<DataTransactionResponseModel> result =
          await remoteDataSources.getTransactionData();
      List<DataTransactionEntity> resultEntity = [];

      for (var items in result) {
        resultEntity.add(items.toEntity());
      }
      if (result != null) {
        return right(resultEntity);
      }
      return left(ServerFailure("Get Data Transaction Error"));
    } catch (e) {
      return Left(
          ServerFailure("Get Data Transaction Error Data Repository $e"));
    }
  }

  @override
  Future<Either<ServerFailure, List<DataTransactionEntity>>> filterItemByDate(
      DateTime startDate, DateTime endDate) async {
    try {
      List<DataTransactionResponseModel> result =
          await remoteDataSources.filterDatabyDate(startDate, endDate);
      List<DataTransactionEntity> resultEntity = [];

      for (var items in result) {
        resultEntity.add(items.toEntity());
      }
      if (result != null) {
        return right(resultEntity);
      } else {
        return left(ServerFailure("Filter Item By Date Error"));
      }
    } catch (e) {
      return Left(
          ServerFailure("Filter Item By Date Error Data Repository $e"));
    }
  }
}
