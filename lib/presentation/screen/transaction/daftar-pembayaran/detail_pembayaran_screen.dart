import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/presentation/screen/transaction/qr/qrpage_screen.dart';

class DetailPembayaranScreen extends StatefulWidget {
  final List<dynamic> data;
  final String orderId;
  final String transactionDate;
  final String priceTotal;
  final String midTransLink;

  const DetailPembayaranScreen(
      {required this.data,
      required this.orderId,
      required this.transactionDate,
      required this.priceTotal,
      required this.midTransLink,
      super.key});

  @override
  State<DetailPembayaranScreen> createState() => _DetailPembayaranScreenState();
}

class _DetailPembayaranScreenState extends State<DetailPembayaranScreen> {
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
          "Order #${widget.orderId}",
          style:
              ThemeText.dashboardHeader.copyWith(color: ThemeColor.blackColor),
        ),
      ),
      backgroundColor: ThemeColor.backgroundColor,
      body: ListView.builder(
          itemCount: widget.data.length,
          itemBuilder: ((context, index) {
            var items = widget.data;
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
                          items[index]['productName'].toString(),
                          style: ThemeText.regular,
                        ),
                      ),
                      SizedBox(
                          width: width * 0.1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "x${items[index]['count'].toString()}",
                              style: ThemeText.regular,
                            ),
                          )),
                      SizedBox(
                        width: width * 0.2,
                        child: Text(
                          NumberFormat.currency(
                                  decimalDigits: 0, symbol: 'IDR ')
                              .format(int.tryParse(
                            items[index]['productPrice'].toString(),
                          )),
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
        height: height * 0.26,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            QrPageScreen(mindTransLink: widget.midTransLink)));
              },
              child: Container(
                height: height * 0.05,
                width: width * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ThemeColor.whiteColor,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          offset: const Offset(0, 2),
                          color: ThemeColor.blackColor.withOpacity(0.2))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.qr_code_2_rounded),
                      Text(
                        "QR CODE",
                        style: ThemeText.dashboardHeader.copyWith(
                            color: ThemeColor.blackColor, fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Container(
                height: height * 0.15,
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
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
                                  .format(int.tryParse(widget.priceTotal)),
                              style:
                                  ThemeText.regularBold.copyWith(fontSize: 16),
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
                              widget.transactionDate,
                              style:
                                  ThemeText.regularBold.copyWith(fontSize: 16),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
