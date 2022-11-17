import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sembako_bintang/data/model/dashboard/menu_response_model.dart';
import 'package:sembako_bintang/data/model/transaction/barang/barang_response_model.dart';
import 'package:sembako_bintang/data/model/transaction/cart/cart_response_model.dart';

abstract class LocalDataSources {
  Future fetchMenuDashboard();
  Future fetchBarangTransaction();
  Future cartTransaction();
}

class LocalDataSourcesImpl implements LocalDataSources {
  @override
  Future fetchMenuDashboard() async {
    try {
      final result = await rootBundle.loadString("assets/json/menu.json");
      final decodeResult = jsonDecode(result);
      final resultReturn = MenuResponseModel.fromJson(decodeResult);

      return resultReturn;
    } catch (e) {
      debugPrint("Catch Error Data Source Menu Dashboard : $e");
      return e;
    }
  }

  @override
  Future fetchBarangTransaction() async {
    try {
      final result = await rootBundle.loadString("assets/json/barang.json");
      final decodeResult = jsonDecode(result);
      final resultReturn = BarangResponseModel.fromJson(decodeResult);

      return resultReturn;
    } catch (e) {
      debugPrint("Catch Error Data Source Barang Transaction : $e");
      return e;
    }
  }

  @override
  Future cartTransaction() async {
    try {
      final result = await rootBundle.loadString("assets/json/cart.json");
      final decodeResult = jsonDecode(result);
      final resultReturn = CartResponseModel.fromJson(decodeResult);

      return resultReturn;
    } catch (e) {
      debugPrint("Catch Error Data Source Cart Transaction : $e");
      return e;
    }
  }
}
