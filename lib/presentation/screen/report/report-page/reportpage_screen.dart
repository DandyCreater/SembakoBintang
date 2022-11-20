// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';

class ReportPageScreen extends StatefulWidget {
  const ReportPageScreen({super.key});

  @override
  State<ReportPageScreen> createState() => _ReportPageScreenState();
}

class _ReportPageScreenState extends State<ReportPageScreen> {
  final endDateTimeController = TextEditingController();
  final startDateTimeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    DateTime endDateTime = DateTime.now();
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

      if (newSelected != null && newSelected != endDateTime) {
        endDateTime = newSelected;
        endDateTimeController.text =
            dateFormat.format(endDateTime.toLocal()).split(" ")[0];
      }
    }

    return Scaffold(
      backgroundColor: ThemeColor.backgroundColor,
      body: SingleChildScrollView(
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
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(10, 20, 8, 20),
                                  isDense: true,
                                  isCollapsed: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(17),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: ThemeColor.activeTextFieldColor),
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
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(10, 20, 8, 20),
                                  isDense: true,
                                  isCollapsed: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(17),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: ThemeColor.activeTextFieldColor),
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
          ],
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
                  Navigator.pushNamed(context, detailFilterReportScreen);
                },
                child: Text(
                  "Search",
                  style: ThemeText.buttonStartedText,
                )),
          ),
        ),
      ),
    );
  }
}
