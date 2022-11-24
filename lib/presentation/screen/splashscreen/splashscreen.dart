import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sembako_bintang/data/model/items/items_response_model.dart';
import 'package:sembako_bintang/data/model/transaction/cart/cart_responses_model.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot<Map<String, dynamic>> dataItem =
        await firestore.collection('cart').get();

    final allData =
        dataItem.docs.map((e) => CartResponseModel.fromJson(e)).toList();
    debugPrint("All Data ${allData}");
    List<CartResponseModel> datafinal = [];
    for (var i = 0; i < allData.length; i++) {
      var data = allData[i];
      debugPrint("Data ${data.productName}");
      for (var j = 0; j < allData.length; j++) {
        if (data.cartId == allData[j].cartId) {
          var countInt = int.tryParse(data.count!);
          debugPrint("count int $countInt");
          countInt = countInt! + 1;
          data.count = countInt.toString();
        }
      }
      datafinal.add(data);
    }
    debugPrint("data 1 " + datafinal[0].count.toString());
    debugPrint("data 2 " + datafinal[1].count.toString());
    debugPrint("data 3 " + datafinal[2].count.toString());
  }

  @override
  void initState() {
    // getData();
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 4)).then((value) =>
        Navigator.pushNamedAndRemoveUntil(
            context, getStartedScreen, (route) => false));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.primaryColor,
      body: Center(
        child: Text("S E M B A K O", style: ThemeText.splashText),
      ),
    );
  }
}
