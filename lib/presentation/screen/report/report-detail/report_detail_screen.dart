import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';

class ReportDetailScreen extends StatelessWidget {
  final List<dynamic> data;
  final String orderId;
  final String transactionDate;
  final String priceTotal;

  const ReportDetailScreen(
      {required this.data,
      required this.orderId,
      required this.transactionDate,
      required this.priceTotal,
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
          "Order #$orderId",
          style:
              ThemeText.dashboardHeader.copyWith(color: ThemeColor.blackColor),
        ),
      ),
      backgroundColor: ThemeColor.backgroundColor,
      body: ListView.builder(
          itemCount: data.length,
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
                      SizedBox(
                        width: width * 0.3,
                        child: Text(
                          data[index]['productName'],
                          style: ThemeText.regular,
                        ),
                      ),
                      SizedBox(
                          width: width * 0.1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "x${data[index]['count']}",
                              style: ThemeText.regular,
                            ),
                          )),
                      SizedBox(
                        width: width * 0.2,
                        child: Text(
                          NumberFormat.currency(decimalDigits: 0, symbol: 'IDR ')
                              .format(int.tryParse(data[index]['productPrice'])),
                          style: ThemeText.regularBold,
                        ),
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
                        width: width * 0.35,
                        child: Text(
                          "Total Harga",
                          style: ThemeText.regular,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: width * 0.32,
                        child: Text(
                          NumberFormat.currency(
                                  symbol: 'IDR ', decimalDigits: 0)
                              .format(int.tryParse(priceTotal)),
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
                        width: width * 0.35,
                        child: Text(
                          "Tanggal",
                          style: ThemeText.regular,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: width * 0.32,
                        child: Text(
                          transactionDate,
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
