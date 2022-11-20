import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';

class ReportDetailScreen extends StatelessWidget {
  final String? orderNumber;
  final String? productName;
  final String? qty;
  final String? nominal;
  const ReportDetailScreen(
      {required this.orderNumber,
      required this.productName,
      required this.qty,
      required this.nominal,
      super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ThemeColor.blackColor,
            )),
        elevation: 0,
        backgroundColor: ThemeColor.backgroundColor,
        title: Text(
          "Order #$orderNumber",
          style:
              ThemeText.dashboardHeader.copyWith(color: ThemeColor.blackColor),
        ),
      ),
      backgroundColor: ThemeColor.backgroundColor,
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                width: width,
                height: height * 0.06,
                decoration:
                    BoxDecoration(color: ThemeColor.whiteColor, boxShadow: [
                  BoxShadow(
                    color: ThemeColor.blackColor.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productName!,
                        style: ThemeText.regular,
                      ),
                      SizedBox(
                          width: width * 0.4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "x${qty!}",
                              style: ThemeText.regular,
                            ),
                          )),
                      Text(
                        NumberFormat.currency(decimalDigits: 0, symbol: 'IDR ')
                            .format(int.tryParse(nominal!)),
                        style: ThemeText.regularBold,
                      )
                    ],
                  ),
                ),
              ),
            );
          })),
      bottomNavigationBar: SizedBox(
        width: width,
        height: height * 0.2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Container(
            height: height * 0.06,
            width: width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ThemeColor.blackColor.withOpacity(0.2),
                  offset: const Offset(0, 2),
                  spreadRadius: 1,
                  blurRadius: 1,
                )
              ],
              color: ThemeColor.whiteColor,
              borderRadius: BorderRadius.circular(17),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 20,
                        width: width * 0.1,
                        child: SvgPicture.asset("assets/icon/icon_circle.svg"),
                      ),
                      SizedBox(
                        height: 20,
                        width: width * 0.4,
                        child: Text(
                          "Total Harga",
                          style: ThemeText.regular,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: width * 0.3,
                        child: Text(
                          NumberFormat.currency(
                                  symbol: 'IDR ', decimalDigits: 0)
                              .format(int.tryParse("21000")),
                          style: ThemeText.regularBold.copyWith(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 20,
                        width: width * 0.1,
                        child: SvgPicture.asset("assets/icon/icon_circle.svg"),
                      ),
                      SizedBox(
                        height: 20,
                        width: width * 0.4,
                        child: Text(
                          "Tanggal",
                          style: ThemeText.regular,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: width * 0.3,
                        child: Text(
                          "11-11-2022",
                          style: ThemeText.regularBold.copyWith(fontSize: 18),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
