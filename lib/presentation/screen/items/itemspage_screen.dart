import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/presentation/bloc/get-item/get_item_bloc.dart';

class ItemsPageScreen extends StatelessWidget {
  const ItemsPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height * 0.5,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/items_bg.png"),
                    fit: BoxFit.cover),
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
                            horizontal: 20, vertical: 60),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: height * 0.1,
                              width: width * 0.32,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              ThemeColor.primaryColor),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(17)))),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, tambahBarangScreen);
                                  },
                                  child: Text(
                                    "Tambah barang",
                                    style: ThemeText.buttonStartedText,
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                            SizedBox(
                              height: height * 0.1,
                              width: width * 0.32,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              ThemeColor.primaryColor),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(17)))),
                                  onPressed: () {
                                    BlocProvider.of<GetItemBloc>(context)
                                        .add(FetchGetItem());
                                    Navigator.pushNamed(
                                        context, itemEditScreen);
                                  },
                                  child: Text(
                                    "Edit Barang",
                                    style: ThemeText.buttonStartedText,
                                    textAlign: TextAlign.center,
                                  )),
                            )
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
    );
  }
}
