import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/domain/entity/transaction/data-transaction/data_transaction_entity.dart';
import 'package:sembako_bintang/presentation/bloc/reports-filter/reports_filter_bloc.dart';
import 'package:sembako_bintang/presentation/screen/report/report-detail/report_detail_screen.dart';
import 'package:skeletons/skeletons.dart';

class DetailFilterReportScreen extends StatefulWidget {
  final String? startDateTime;
  final String? endDateTime;

  const DetailFilterReportScreen(
      {required this.startDateTime, required this.endDateTime, super.key});

  @override
  State<DetailFilterReportScreen> createState() =>
      _DetailFilterReportScreenState();
}

class _DetailFilterReportScreenState extends State<DetailFilterReportScreen> {
  List<DataTransactionEntity> sortListData = [];
  List dataListOrder = [];
  int? finalPrice;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, reportPageScreen);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: ThemeColor.blackColor,
              )),
          backgroundColor: ThemeColor.backgroundColor,
          elevation: 0,
          title: Text("Laporan Penjualan", style: ThemeText.dashboardHeader),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<ReportsFilterBloc, ReportsFilterState>(
                builder: (context, state) {
                  if (state is ReportsFilterSuccess) {
                    for (var i = 0; i < state.value!.length; i++) {
                      var intData = int.tryParse(state.value![i].totalPrice!);
                      dataListOrder
                          .add(intData);
                    }
                    if (dataListOrder.isEmpty) {
                      setState(() {
                        finalPrice = 0;
                      });
                    } else {
                      finalPrice = dataListOrder
                          .reduce(((value, element) => value + element));
                    }
                    return SizedBox(
                      height: height * 0.25,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Container(
                          height: height * 0.19,
                          width: width,
                          decoration: BoxDecoration(
                              color: ThemeColor.whiteColor,
                              borderRadius: BorderRadius.circular(17)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: width * 0.1,
                                      child: SvgPicture.asset(
                                          "assets/icon/icon_circle.svg"),
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
                                        widget.startDateTime!,
                                        style: ThemeText.regularBold
                                            .copyWith(fontSize: 18),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: width * 0.1,
                                      child: SvgPicture.asset(
                                          "assets/icon/icon_circle.svg"),
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
                                        widget.endDateTime!,
                                        style: ThemeText.regularBold
                                            .copyWith(fontSize: 18),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: width * 0.1,
                                      child: SvgPicture.asset(
                                          "assets/icon/icon_circle.svg"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: width * 0.4,
                                      child: Text(
                                        "Total Order",
                                        style: ThemeText.regular,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: width * 0.3,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right : 6.0),
                                          child: Text(
                                            state.value!.length.toString(),
                                            style: ThemeText.regularBold
                                                .copyWith(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: width * 0.1,
                                      child: SvgPicture.asset(
                                          "assets/icon/icon_circle.svg"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: width * 0.4,
                                      child: Text(
                                        "Total Income",
                                        style: ThemeText.regular,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: width * 0.3,
                                      child: Text(
                                        NumberFormat.currency(
                                                  symbol: 'IDR ',
                                                  decimalDigits: 0)
                                              .format(finalPrice),
                                        style: ThemeText.regularBold
                                            .copyWith(fontSize: 18),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(
                height: height * 0.7,
                child: BlocBuilder<ReportsFilterBloc, ReportsFilterState>(
                  builder: (context, state) {
                    if (state is ReportsFilterSuccess) {
                      var items = state.value;
                      for (var data in items!) {
                        sortListData.add(data);
                      }

                      sortListData
                          .sort(((a, b) => a.orderId!.compareTo(b.orderId!)));

                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            ReportDetailScreen(
                                                data: sortListData[index].data,
                                                orderId: sortListData[index]
                                                    .orderId!,
                                                transactionDate:
                                                    sortListData[index]
                                                        .transactionDate!,
                                                priceTotal: sortListData[index]
                                                    .totalPrice!))));
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
                                        color: ThemeColor.blackColor
                                            .withOpacity(0.2),
                                        offset: const Offset(0, 2),
                                        blurRadius: 1,
                                        spreadRadius: 0,
                                      )
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Order #${sortListData[index].orderId!}",
                                              style: ThemeText.regularBold,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Number of items ",
                                                  style: ThemeText.regularBold,
                                                ),
                                                Text(
                                                  sortListData[index]
                                                      .numberOfItems!,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              sortListData[index]
                                                  .transactionTime!,
                                              style: ThemeText.regularBold,
                                            ),
                                            Text(
                                              NumberFormat.currency(
                                                      decimalDigits: 0,
                                                      symbol: 'IDR ')
                                                  .format(int.tryParse(
                                                      sortListData[index]
                                                          .totalPrice!)),
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
                      height: height * 0.7,
                      width: width,
                      child: const SkeletonAvatar(),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: height * 0.15,
                  width: width * 0.12,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: ThemeColor.blackColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, homepageScreen, (route) => false);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
