// ignore_for_file: use_build_context_synchronously, avoid_init_to_null, prefer_if_null_operators

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/domain/entity/items/items_entity.dart';
import 'package:sembako_bintang/presentation/bloc/get-item/get_item_bloc.dart';

class EditItemBarangScreen extends StatefulWidget {
  final String? id;
  final String? itemName;
  final String? price;
  final String? image;
  const EditItemBarangScreen(
      {required this.id,
      required this.itemName,
      required this.price,
      required this.image,
      super.key});

  @override
  State<EditItemBarangScreen> createState() => _EditItemBarangScreenState();
}

class _EditItemBarangScreenState extends State<EditItemBarangScreen> {
  File? image = null;
  final namaBarangController = TextEditingController();
  final hargaBarangController = TextEditingController();

  getCondition() async {
    setState(() {
      namaBarangController.text = widget.itemName!;
      hargaBarangController.text = widget.price!;
    });
  }

  pickImageFromGallery() async {
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

  pickImageFromCamera() async {
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

  initDialog() async {
    if (hargaBarangController.text == widget.price &&
        namaBarangController.text == widget.itemName &&
        image == null) {
      failedDialog(context, "Data tidak ada perubahan", "Update Data Error");
    } else {
      processDialog("Update Item", "Anda yakin ingin mengupdate item ?");
    }
  }

  processDialog(String title, String bodyText) {
    Widget acceptButton = TextButton(
      onPressed: () {
        BlocProvider.of<GetItemBloc>(context).add(UpdateDataItem(
            dataItem: ItemsEntity(
              id: widget.id,
              price: hargaBarangController.text,
              productName: namaBarangController.text,
              productImage: widget.image,
              selected: false,
              addCart: false,
            ),
            imageFile: image == null ? File('') : image));
        Navigator.pop(context);
      },
      child: Text("OK", style: ThemeText.regularBold),
    );
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text("Cancel", style: ThemeText.regularBold),
    );

    AlertDialog alert = AlertDialog(
      title: Center(
        child: Text(title, style: ThemeText.regularBold),
      ),
      content: SizedBox(
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset("assets/lottie/create.json")),
            Text(bodyText, style: ThemeText.regular),
          ],
        ),
      ),
      actions: [
        acceptButton,
        cancelButton,
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  successDialog(String title, String bodyText) {
    Widget acceptButton = TextButton(
      onPressed: () {
        // Navigator.pop(context);
        BlocProvider.of<GetItemBloc>(context).add(FetchGetItem());
        Navigator.pushNamed(context, itemEditScreen);
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
                child: Lottie.asset("assets/lottie/success.json")),
            Text(bodyText, style: ThemeText.regular),
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
  void initState() {
    getCondition();
    // TODO: implement initState
    super.initState();
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
          "Update Barang",
          style: ThemeText.dashboardHeader,
        ),
      ),
      body: SingleChildScrollView(
        child: BlocListener<GetItemBloc, GetItemState>(
          listener: (context, state) {
            if (state is UpdateDataItemSuccess) {
              successDialog("Update Item Success", "Item berhasil di update");
            }
          },
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
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: const BorderSide(
                            color: ThemeColor.dashboardTextSubTitleColor),
                      ),
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
                          : Container(
                              height: height * 0.2,
                              width: width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(widget.image!),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(17)),
                            )),
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
                  initDialog();
                },
                child: Text(
                  "Update",
                  style: ThemeText.buttonStartedText,
                )),
          ),
        ),
      ),
    );
  }
}
