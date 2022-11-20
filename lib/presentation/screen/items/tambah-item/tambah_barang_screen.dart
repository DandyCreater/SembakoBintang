import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';

class TambahBarangScreen extends StatefulWidget {
  const TambahBarangScreen({super.key});

  @override
  State<TambahBarangScreen> createState() => _TambahBarangScreenState();
}

class _TambahBarangScreenState extends State<TambahBarangScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ThemeColor.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: ThemeColor.backgroundColor,
        title: Text(
          "Tambah Barang",
          style: ThemeText.dashboardHeader,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama barang",
                style: ThemeText.regular
                    .copyWith(color: ThemeColor.dashboardTextTitleColor),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 15, 4, 15),
                    hintText: "Nama Barang",
                    hintStyle: ThemeText.regular.copyWith(
                        color: ThemeColor.blackColor.withOpacity(0.2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: const BorderSide(
                            color: ThemeColor.dashboardTextSubTitleColor)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                      borderSide: const BorderSide(
                          color: ThemeColor.dashboardTextSubTitleColor),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Harga Barang",
                style: ThemeText.regular
                    .copyWith(color: ThemeColor.dashboardTextTitleColor),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 15, 4, 15),
                    hintText: "Harga Barang",
                    hintStyle: ThemeText.regular.copyWith(
                        color: ThemeColor.blackColor.withOpacity(0.2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: const BorderSide(
                            color: ThemeColor.dashboardTextSubTitleColor)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                      borderSide: const BorderSide(
                          color: ThemeColor.dashboardTextSubTitleColor),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Foto Barang",
                style: ThemeText.regular
                    .copyWith(color: ThemeColor.dashboardTextTitleColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: height * 0.2,
                width: width,
                decoration: BoxDecoration(
                    color: ThemeColor.whiteColor,
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                        color: ThemeColor.dashboardTextTitleColor, width: 0.6)),
                child: Center(
                  child: Text("Upload Picture Here",
                      style: ThemeText.regular
                          .copyWith(color: ThemeColor.dashboardTextTitleColor)),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: height * 0.14,
        width: width,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.035, horizontal: width * 0.3),
          child: SizedBox(
            height: height * 0.07,
            width: width * 0.5,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ThemeColor.primaryColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17)))),
                onPressed: () {},
                child: Text(
                  "Tambah",
                  style: ThemeText.buttonStartedText,
                )),
          ),
        ),
      ),
    );
  }
}
