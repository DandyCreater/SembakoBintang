// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/presentation/bloc/reports-filter/reports_filter_bloc.dart';
import 'package:sembako_bintang/presentation/screen/report/report-page/detail_filter_report_screen.dart';

class ReportPageScreen extends StatefulWidget {
  const ReportPageScreen({super.key});

  @override
  State<ReportPageScreen> createState() => _ReportPageScreenState();
}

class _ReportPageScreenState extends State<ReportPageScreen> {
  final endDateTimeController = TextEditingController();
  final startDateTimeController = TextEditingController();

  failedDialog(BuildContext context, String message, String title) {
    Widget acceptButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text("OK", style: ThemeText.regularBold),
    );

    AlertDialog alert = AlertDialog(
      title: Center(
        child: Text(title, style: ThemeText.regularBold),
      ),
      content: SizedBox(
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset('assets/lottie/failed.json')),
            Text(message, style: ThemeText.regular),
          ],
        ),
      ),
      actions: [
        acceptButton,
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    DateTime endDateTime = DateTime.now();
    DateTime endDateTimeFormat = DateTime.now();
    DateTime startDateTime =
        DateTime(endDateTime.year, endDateTime.month, endDateTime.day - 7);

    Future<void> selectStartDate(BuildContext context) async {
      DateTime? newSelected = await showDatePicker(
        context: context,
        initialDate: startDateTime,
        firstDate: DateTime(1945),
        lastDate: DateTime(2045),
      );

      if (newSelected != null && newSelected != startDateTime) {
        startDateTime = newSelected;
        startDateTimeController.text =
            dateFormat.format(startDateTime.toLocal()).split(" ")[0];
      }
    }

    Future<void> selectEndDate(BuildContext context) async {
      DateTime? newSelected = await showDatePicker(
        context: context,
        initialDate: endDateTime,
        firstDate: DateTime(1945),
        lastDate: DateTime(2045),
      );
      DateTime? selectedFormat =
          DateTime(newSelected!.year, newSelected.month, newSelected.day + 1);

      if (newSelected != null && newSelected != endDateTime) {
        endDateTime = selectedFormat;
        endDateTimeFormat = newSelected;
        endDateTimeController.text =
            dateFormat.format(newSelected.toLocal()).split(" ")[0];
      }
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ThemeColor.backgroundColor,
        body: SingleChildScrollView(
          child: BlocListener<ReportsFilterBloc, ReportsFilterState>(
            listener: (context, state) {
              if (state is ReportsFilterSuccess) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => DetailFilterReportScreen(
                            startDateTime: startDateTime.toString(),
                            endDateTime: endDateTimeFormat.toString()))));
              }
            },
            child: Stack(
              children: [
                Container(
                  height: height * 0.5,
                  width: width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/report_bg.png"),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: height * 0.32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reports",
                        style: ThemeText.dashboardHeader
                            .copyWith(color: ThemeColor.whiteColor),
                      ),
                      Text(
                        "Silahkan fliter tanggalnya",
                        style: ThemeText.dashboardSubHeader
                            .copyWith(color: ThemeColor.whiteColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: height * 0.42),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Container(
                          width: width,
                          height: height * 0.42,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: ThemeColor.whiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: ThemeColor.blackColor.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 1),
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tanggal",
                                  style: ThemeText.regular,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  onTap: () => selectStartDate(context),
                                  readOnly: true,
                                  controller: startDateTimeController,
                                  decoration: InputDecoration(
                                      hintText:
                                          "${dateFormat.format(startDateTime.toLocal()).split(" ")[0]}",
                                      hintStyle: ThemeText.regular,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          10, 20, 8, 20),
                                      isDense: true,
                                      isCollapsed: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(17),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                                ThemeColor.activeTextFieldColor),
                                        borderRadius: BorderRadius.circular(17),
                                      )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    "Sampai",
                                    style: ThemeText.regular,
                                  ),
                                ),
                                Text(
                                  "Tanggal",
                                  style: ThemeText.regular,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  onTap: () => selectEndDate(context),
                                  readOnly: true,
                                  controller: endDateTimeController,
                                  decoration: InputDecoration(
                                      hintText:
                                          "${dateFormat.format(endDateTime.toLocal()).split(" ")[0]}",
                                      hintStyle: ThemeText.regular,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          10, 20, 8, 20),
                                      isDense: true,
                                      isCollapsed: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(17),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                                ThemeColor.activeTextFieldColor),
                                        borderRadius: BorderRadius.circular(17),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
        bottomNavigationBar: SizedBox(
          height: height * 0.15,
          width: width,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.3, vertical: height * 0.04),
            child: SizedBox(
              height: height * 0.07,
              width: width * 0.1,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17))),
                      backgroundColor:
                          MaterialStateProperty.all(ThemeColor.primaryColor)),
                  onPressed: () {
                    if (startDateTime.compareTo(endDateTime) > 0) {
                      failedDialog(context, "Tanggal Awal Salah",
                          "Format Tanggal Salah !");
                    }
                    if (endDateTime.compareTo(DateTime.now()) > 0) {
                      failedDialog(context, "Tanggal Akhir Salah",
                          "Format Tanggal Salah !");
                    }
                    if (startDateTime.compareTo(endDateTime) < 0 &&
                        endDateTime.compareTo(DateTime.now()) <= 0) {
                      BlocProvider.of<ReportsFilterBloc>(context).add(
                          StartFilterByDate(
                              startDate: startDateTime, endDate: endDateTime));
                    }
                  },
                  child: Text(
                    "Search",
                    style: ThemeText.buttonStartedText,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
