import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';

class ItemCartTransaction extends StatelessWidget {
  String? imageUrl;
  String? title;
  String? count;
  String? price;

  ItemCartTransaction(
      {required this.imageUrl,
      required this.title,
      required this.count,
      required this.price,
      super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(10),
      width: width,
      height: height * 0.14,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: ThemeColor.whiteColor,
          boxShadow: [
            BoxShadow(
                color: ThemeColor.blackColor.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 2,
                offset: const Offset(0, 1))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: height,
            width: width * 0.2,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 70,
                width: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(imageUrl!), fit: BoxFit.cover)),
              ),
            ),
          ),
          SizedBox(
            height: height,
            width: width * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: ThemeText.regular,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove_circle),
                      color: ThemeColor.optionColor,
                    ),
                    Text(
                      count!,
                      style: ThemeText.regular,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle),
                      color: ThemeColor.optionColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: height,
            width: 100,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    NumberFormat.currency(decimalDigits: 0, symbol: 'IDR ')
                        .format(int.tryParse(price!)),
                    style: ThemeText.regularBold,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Icon(
                      Icons.highlight_off,
                      color: ThemeColor.blackColor.withOpacity(0.2),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
