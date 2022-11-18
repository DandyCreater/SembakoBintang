import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';

class DaftarPembayaranScreen extends StatefulWidget {
  const DaftarPembayaranScreen({super.key});

  @override
  State<DaftarPembayaranScreen> createState() => _DaftarPembayaranScreenState();
}

class _DaftarPembayaranScreenState extends State<DaftarPembayaranScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    Widget pendingPage() => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 6,
        itemBuilder: ((context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: height * 0.15,
            width: width,
            decoration: BoxDecoration(color: ThemeColor.whiteColor, boxShadow: [
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order #240",
                          style: ThemeText.regularBold,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        NumberFormat.currency(decimalDigits: 0, symbol: 'IDR ')
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
                    padding:
                        const EdgeInsets.only(top: 20, bottom: 15, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order #240",
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
                                              BorderRadius.circular(17))),
                                  backgroundColor: MaterialStateProperty.all(
                                      ThemeColor.unpaidButtonColor)),
                              onPressed: () {},
                              child: Text(
                                "Unpaid",
                                style: ThemeText.buttonStartedText,
                              )),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }));

    Widget completedPage() => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 6,
        itemBuilder: ((context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: height * 0.15,
            width: width,
            decoration: BoxDecoration(color: ThemeColor.whiteColor, boxShadow: [
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order #240",
                          style: ThemeText.regularBold,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        NumberFormat.currency(decimalDigits: 0, symbol: 'IDR ')
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
                    padding:
                        const EdgeInsets.only(top: 20, bottom: 15, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              BorderRadius.circular(17))),
                                  backgroundColor: MaterialStateProperty.all(
                                      ThemeColor.paidButtonColor)),
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
          );
        }));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: height * 0.14,
        elevation: 0,
        backgroundColor: ThemeColor.backgroundColor,
        title: Center(
          child: Text(
            "Daftar Pembayaran",
            style: ThemeText.dashboardHeader,
          ),
        ),
        bottom: TabBar(
            indicatorColor: ThemeColor.blackColor,
            padding: const EdgeInsets.symmetric(horizontal: 60),
            controller: controller,
            isScrollable: false,
            labelColor: ThemeColor.blackColor,
            labelStyle: ThemeText.regular,
            // ignore: prefer_const_literals_to_create_immutables
            tabs: [
              const Tab(
                text: "Pending",
              ),
              const Tab(
                text: "Completed",
              ),
            ]),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          pendingPage(),
          completedPage(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: height * 0.2,
        width: width,
        child: Center(
          child: SizedBox(
            height: height * 0.09,
            width: width * 0.65,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17))),
                      backgroundColor:
                          MaterialStateProperty.all(ThemeColor.primaryColor)),
                  onPressed: () {},
                  child: Text(
                    "Halaman Utama",
                    style: ThemeText.buttonStartedText,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
