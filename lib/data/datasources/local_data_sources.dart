import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sembako_bintang/data/model/dashboard/menu_response_model.dart';
import 'package:sembako_bintang/data/model/transaction/barang/barang_response_model.dart';

abstract class LocalDataSources {
  Future fetchMenuDashboard();
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
}
