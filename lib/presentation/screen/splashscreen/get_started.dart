import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/presentation/screen/homepage/homepage.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/get_started.png"),
                    fit: BoxFit.cover)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: height * 0.03),
              child: SizedBox(
                height: height * 0.06,
                width: width * 0.45,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(17))),
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColor.primaryColor)),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, homepageScreen, (route) => false);
                    },
                    child: Text(
                      "Ayo Mulai",
                      style: ThemeText.buttonStartedText,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
