// ignore_for_file: unused_element, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/presentation/bloc/tambah-barang/tambah_barang_bloc.dart';

class TambahBarangScreen extends StatefulWidget {
  const TambahBarangScreen({super.key});

  @override
  State<TambahBarangScreen> createState() => _TambahBarangScreenState();
}

class _TambahBarangScreenState extends State<TambahBarangScreen> {
  File? image;
  final namaBarangController = TextEditingController();
  final hargaBarangController = TextEditingController();

  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      Navigator.pop(context);
    } on PlatformException catch (e) {
      debugPrint("Failed to Pick Image : $e");
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      Navigator.pop(context);
    } on PlatformException catch (e) {
      debugPrint("Failed to Pick Image : $e");
    }
  }

  showDialogFile(
      BuildContext context, String message, String title, String lottieAsset) {
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
            SizedBox(height: 100, width: 100, child: Lottie.asset(lottieAsset)),
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

  inputCondition() async {
    if (hargaBarangController.text.isNotEmpty &&
        namaBarangController.text.isNotEmpty &&
        image != null) {
      BlocProvider.of<TambahBarangBloc>(context).add(InputBarang(
          price: hargaBarangController.text,
          productName: namaBarangController.text,
          imageFile: image!));
    } else {
      showDialogFile(context, "Kolom tidak boleh kosong", "Tambah Data Gagal",
          'assets/lottie/failed.json');
    }
  }

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
      body: BlocListener<TambahBarangBloc, TambahBarangState>(
        listener: (context, state) {
          if (state is TambahBarangSuccess) {
            showDialogFile(context, "Tambah Barang Berhasil", "Berhasil",
                'assets/lottie/success.json');
            Future.delayed(const Duration(seconds: 2))
                .then((value) => Navigator.pushNamed(context, itemsPageScreen));
          }
          if (state is TambahBarangFailed) {
            showDialogFile(context, state.message!, "Terjadi Kesalahan",
                'assets/lottie/failed.json');
          }
        },
        child: SingleChildScrollView(
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
                  controller: namaBarangController,
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
                  controller: hargaBarangController,
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
                InkWell(
                  onTap: () async {
                    await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: height * 0.3,
                            width: width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.08,
                                  horizontal: width * 0.24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () => pickImageFromCamera(),
                                    child: Container(
                                      height: height * 0.12,
                                      width: width * 0.21,
                                      decoration: BoxDecoration(
                                          color: ThemeColor.whiteColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color: ThemeColor.blackColor
                                                  .withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                              offset: const Offset(0, 2),
                                            )
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.camera_alt_outlined,
                                            color: ThemeColor.blackColor
                                                .withOpacity(0.2),
                                          ),
                                          Text(
                                            "Camera",
                                            style: ThemeText.regular,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => pickImageFromGallery(),
                                    child: Container(
                                      height: height * 0.12,
                                      width: width * 0.21,
                                      decoration: BoxDecoration(
                                          color: ThemeColor.whiteColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color: ThemeColor.blackColor
                                                  .withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                              offset: const Offset(0, 2),
                                            )
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image,
                                            color: ThemeColor.blackColor
                                                .withOpacity(0.2),
                                          ),
                                          Text(
                                            "Galery",
                                            style: ThemeText.regular,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    height: height * 0.2,
                    width: width,
                    decoration: BoxDecoration(
                        color: ThemeColor.whiteColor,
                        borderRadius: BorderRadius.circular(17),
                        border: Border.all(
                            color: ThemeColor.dashboardTextTitleColor,
                            width: 0.6)),
                    child: image != null
                        ? Container(
                            height: height * 0.2,
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17)),
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: Text("Upload Picture Here",
                                style: ThemeText.regular.copyWith(
                                    color: ThemeColor.dashboardTextTitleColor)),
                          ),
                  ),
                ),
              ],
            ),
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
                onPressed: () {
                  inputCondition();
                },
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
