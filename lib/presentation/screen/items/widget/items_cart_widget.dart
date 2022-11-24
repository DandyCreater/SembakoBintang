import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';

class ItemsCartWidget extends StatelessWidget {
  String? imageUrl;
  String? title;
  String? price;
  bool selected;
  Function() press;

   ItemsCartWidget({
    required this.imageUrl,
      required this.title,
      required this.price,
      required this.press,
      required this.selected,
    super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        height: height * 0.34,
        width: width * 0.35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.23,
              width: width * 0.35,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imageUrl!), fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                        color: ThemeColor.blackColor.withOpacity(0.2),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: const Offset(0, 4))
                  ],
                  border:
                      Border.all(color: (selected) ? Colors.green : Colors.transparent),
                  borderRadius: const BorderRadius.all(Radius.circular(18))),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: ThemeText.dashboardHeader
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    NumberFormat.currency(
                      decimalDigits: 0,
                      symbol: "IDR ",
                    ).format(int.tryParse(price!)),
                    style: ThemeText.dashboardSubHeader.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}