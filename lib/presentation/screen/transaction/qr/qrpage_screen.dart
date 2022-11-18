import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';

class QrPageScreen extends StatelessWidget {
  const QrPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pembayaran",
          style: ThemeText.dashboardHeader,
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: ThemeColor.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height * 0.4,
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: ThemeColor.whiteColor),
                child: Center(
                  child: QrImage(
                    data: "Testing QR",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: width,
                height: height * 0.14,
                child: Text(
                  "Silahkan scan QR Code diatas untuk menyelesaikan pembayaran",
                  style: ThemeText.dashboardHeader.copyWith(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
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
                    Navigator.pushNamed(context, daftarPembayaranScreen);
                  },
                  child: Text(
                    "Daftar Pembayaran",
                    style: ThemeText.buttonStartedText,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}