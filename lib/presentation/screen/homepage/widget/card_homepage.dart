// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';

class CardHomePage extends StatelessWidget {
  String? imageUrl;
  String? title;
  String? subtitle;
  Function() press;
  CardHomePage(
      {required this.imageUrl,
      required this.title,
      required this.subtitle,
      required this.press,
      super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: press,
      child: SizedBox(
        height: height * 0.3,
        width: width * 0.54,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * 0.35,
                width: width * 0.45,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(imageUrl!),fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                        color: ThemeColor.blackColor.withOpacity(0.2),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: const Offset(0, 4))
                  ],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18)),
                ),
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
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      subtitle!,
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
      ),
    );
  }
}
