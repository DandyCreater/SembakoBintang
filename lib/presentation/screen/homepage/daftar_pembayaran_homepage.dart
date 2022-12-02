import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/presentation/bloc/data-transaction/data_transaction_bloc.dart';
import 'package:sembako_bintang/presentation/screen/transaction/daftar-pembayaran/detail_pembayaran_screen.dart';
import 'package:skeletons/skeletons.dart';

class DaftarPembayaranHomepage extends StatefulWidget {
  const DaftarPembayaranHomepage({super.key});

  @override
  State<DaftarPembayaranHomepage> createState() => _DaftarPembayaranHomepageState();
}

class _DaftarPembayaranHomepageState extends State<DaftarPembayaranHomepage> {
    @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
      ),
      body: BlocBuilder<DataTransactionBloc, DataTransactionState>(
        builder: (context, state) {
          if (state is DataTransactionSuccess) {
            var items = state.value;

            items!.sort((a, b) {
              int aDate = DateTime.parse(a.transactionDate ?? '').microsecondsSinceEpoch;
              int bDate = DateTime.parse(b.transactionDate ?? '').microsecondsSinceEpoch;
              return bDate.compareTo(aDate);
            });

            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => DetailPembayaranScreen(
                                    data: items[index].data,
                                    orderId: items[index].orderId!,
                                    priceTotal: items[index].totalPrice!,
                                    transactionDate:
                                        items[index].transactionDate!, midTransLink: items[index].midtransLink!,
                                  ))));
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
                            width: width * 0.35,
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
                                    "Order #${items[index].orderId}",
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
                                        items[index].data.length.toString(),
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
                                    items[index].transactionTime!,
                                    style: ThemeText.regularBold,
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                            decimalDigits: 0, symbol: 'IDR ')
                                        .format(int.tryParse(
                                            items[index].totalPrice!)),
                                    style: ThemeText.regularBold,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }));
          }
          return SizedBox(
            width: width,
            height: height,
            child: const SkeletonAvatar(),
          );
        },
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
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, homepageScreen, (route) => false);
                  },
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