import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/presentation/screen/report/report-detail/report_detail_screen.dart';

class DetailFilterReportScreen extends StatelessWidget {
  const DetailFilterReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ThemeColor.backgroundColor,
        elevation: 0,
        title: Text("Laporan Penjualan", style: ThemeText.dashboardHeader),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.2,
              width: width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Container(
                  height: height * 0.19,
                  width: width,
                  decoration: BoxDecoration(
                      color: ThemeColor.whiteColor,
                      borderRadius: BorderRadius.circular(17)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 20,
                            width: width * 0.1,
                            child:
                                SvgPicture.asset("assets/icon/icon_circle.svg"),
                          ),
                          SizedBox(
                            height: 20,
                            width: width * 0.4,
                            child: Text(
                              "Dari Tanggal",
                              style: ThemeText.regular,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            width: width * 0.3,
                            child: Text(
                              "17-11-2022",
                              style:
                                  ThemeText.regularBold.copyWith(fontSize: 18),
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
                            child:
                                SvgPicture.asset("assets/icon/icon_circle.svg"),
                          ),
                          SizedBox(
                            height: 20,
                            width: width * 0.4,
                            child: Text(
                              "Sampai Tanggal",
                              style: ThemeText.regular,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            width: width * 0.3,
                            child: Text(
                              "11-11-2022",
                              style:
                                  ThemeText.regularBold.copyWith(fontSize: 18),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.7,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const ReportDetailScreen(
                                    orderNumber: "240",
                                    productName: "Pocari Sweat",
                                    qty: "2",
                                    nominal: "45000"))));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        height: height * 0.15,
                        width: width,
                        decoration: BoxDecoration(
                            color: ThemeColor.whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: ThemeColor.blackColor.withOpacity(0.2),
                                offset: const Offset(0, 2),
                                blurRadius: 1,
                                spreadRadius: 0,
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: height * 0.15,
                              width: width * 0.34,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  bottom: 20,
                                  left: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order #240",
                                      style: ThemeText.regularBold,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Number of items",
                                          style: ThemeText.regularBold,
                                        ),
                                        Text(
                                          "1",
                                          style: ThemeText.regular,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.15,
                              width: width * 0.27,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    NumberFormat.currency(
                                            decimalDigits: 0, symbol: 'IDR ')
                                        .format(int.tryParse("12000")),
                                    style: ThemeText.regularBold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.15,
                              width: width * 0.3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 15, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "14:10",
                                      style: ThemeText.regularBold,
                                    ),
                                    SizedBox(
                                      height: height * 0.05,
                                      width: width * 0.28,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              17))),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      ThemeColor
                                                          .paidButtonColor)),
                                          onPressed: () {},
                                          child: Text(
                                            "Paid",
                                            style: ThemeText.buttonStartedText,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
