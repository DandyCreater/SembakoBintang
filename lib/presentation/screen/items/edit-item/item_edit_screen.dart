// ignore_for_file: await_only_futures, avoid_single_cascade_in_expression_statements, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/helper/dialog.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/domain/entity/items/items_entity.dart';
import 'package:sembako_bintang/presentation/bloc/get-item/get_item_bloc.dart';
import 'package:sembako_bintang/presentation/screen/items/edit-item/edit_item_barang_screen.dart';
import 'package:sembako_bintang/presentation/screen/items/widget/items_cart_widget.dart';
import 'package:sembako_bintang/presentation/screen/transaction/transaction-menu/widget/item_card.dart';
import 'package:skeletons/skeletons.dart';

class ItemEditScreen extends StatefulWidget {
  const ItemEditScreen({super.key});

  @override
  State<ItemEditScreen> createState() => _ItemEditScreenState();
}

class _ItemEditScreenState extends State<ItemEditScreen> {
  int? count;
  String itemsId = "";
  final searchController = TextEditingController();
  ItemsEntity? itemsData;
  final dialog = DialogHelper();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  successDialog(String title, String bodyText) {
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

  processDialog(String title, String bodyText) {
    Widget acceptButton = TextButton(
      onPressed: () async {
        BlocProvider.of<GetItemBloc>(context)
          ..add(DeleteItem(itemsId: itemsId));

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
                child: Lottie.asset("assets/lottie/make_sure.json")),
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
                Navigator.pushNamed(context, itemsPageScreen);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: ThemeColor.blackColor,
              )),
          elevation: 0,
          backgroundColor: ThemeColor.backgroundColor,
          title: Text(
            "Edit Barang",
            style: ThemeText.dashboardHeader,
          ),
        ),
        body: BlocListener<GetItemBloc, GetItemState>(
          listener: (context, state) {
            if (state is DeleteItemSuccess) {
              successDialog("Delete Item Success", "Item Berhasil di hapus");
              Future.delayed(const Duration(seconds: 2)).then((value) =>
                  BlocProvider.of<GetItemBloc>(context).add(FetchGetItem()));
            }
          },
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Search",
                          style: ThemeText.regular.copyWith(
                              color: ThemeColor.dashboardTextTitleColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              BlocProvider.of<GetItemBloc>(context)
                                  .add(FetchGetItem());
                            }
                            // BlocProvider.of<GetItemBloc>(context).add(
                            //     SearchItem(itemName: searchController.text));
                          },
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<GetItemBloc>(context).add(
                                        SearchItem(
                                            itemName: searchController.text));
                                  },
                                  icon: const Icon(Icons.search)),
                              isDense: true,
                              isCollapsed: true,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 15, 4, 15),
                              hintText: "Nama Barang",
                              hintStyle: ThemeText.regular.copyWith(
                                  color:
                                      ThemeColor.blackColor.withOpacity(0.2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  borderSide: const BorderSide(
                                      color:
                                          ThemeColor.dashboardTextTitleColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  borderSide: const BorderSide(
                                      color: ThemeColor
                                          .dashboardTextSubTitleColor))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: height * 0.68,
                    width: double.infinity,
                    child: BlocBuilder<GetItemBloc, GetItemState>(
                      builder: (context, state) {
                        if (state is GetItemSuccess) {
                          var items = state.itemsEntity;
                          return GridView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 1.5 / 2,
                                      mainAxisSpacing: 10,
                                      crossAxisCount: 2),
                              itemCount: items!.length,
                              itemBuilder: (BuildContext context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ItemsCartWidget(
                                    imageUrl: items[index].productImage,
                                    title: items[index].productName,
                                    price: items[index].price,
                                    press: () {
                                      if (items[index].selected == false) {
                                        setState(() {
                                          count = index;
                                          for (var i = 0;
                                              i < items.length;
                                              i++) {
                                            if (i == index) {
                                              items[i].selected = true;
                                              itemsId = items[i].id.toString();
                                              setState(() {
                                                itemsData = items[i];
                                              });
                                            } else {
                                              items[i].selected = false;
                                            }
                                          }
                                        });
                                      } else {
                                        setState(() {
                                          items[index].selected = false;
                                          count = null;
                                        });
                                      }
                                    },
                                    selected: items[index].selected!,
                                  ),
                                );
                              });
                        }
                        return Container(
                            color: Colors.transparent,
                            height: height,
                            width: width,
                            child: Center(
                              child: Lottie.asset('assets/lottie/loading.json'),
                            ));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: (count != null)
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: height * 0.1,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: height * 0.07,
                        width: width * 0.4,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(17))),
                                backgroundColor: MaterialStateProperty.all(
                                    ThemeColor.primaryColor)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          EditItemBarangScreen(
                                            itemName: itemsData!.productName,
                                            price: itemsData!.price,
                                            id: itemsData!.id,
                                            image: itemsData!.productImage,
                                          ))));
                            },
                            child: Text("Edit",
                                style: ThemeText.buttonStartedText)),
                      ),
                      SizedBox(
                        height: height * 0.07,
                        width: width * 0.4,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(17))),
                                backgroundColor: MaterialStateProperty.all(
                                    ThemeColor.primaryColor)),
                            onPressed: () {
                              processDialog("Delete Item",
                                  "Anda yakin ingin menghapus item ?");
                            },
                            child: Text("Hapus",
                                style: ThemeText.buttonStartedText)),
                      )
                    ],
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
