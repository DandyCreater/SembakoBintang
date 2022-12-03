// ignore_for_file: curly_braces_in_flow_control_structures, unrelated_type_equality_checks, await_only_futures, avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sembako_bintang/data/model/transaction/cart/cart_responses_model.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/helper/dialog.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/domain/entity/items/items_entity.dart';
import 'package:sembako_bintang/domain/entity/transaction/cart/cart_entity.dart';
import 'package:sembako_bintang/presentation/bloc/cart-transaction/cart_transaction_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/get-item/get_item_bloc.dart';
import 'package:sembako_bintang/presentation/screen/transaction/transaction-menu/widget/item_card.dart';
import 'package:skeletons/skeletons.dart';

class TransactionPageScreen extends StatefulWidget {
  const TransactionPageScreen({super.key});

  @override
  State<TransactionPageScreen> createState() => _TransactionPageScreenState();
}

class _TransactionPageScreenState extends State<TransactionPageScreen> {
  final dialog = DialogHelper();
  final searchController = TextEditingController();

  String? itemsId;
  List listScreen = [];
  String listString = '[]';
  int cartCount = 0;

  @override
  void initState() {
    BlocProvider.of<GetItemBloc>(context).add(FetchGetItem());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    successDialog(String title, String bodyText) {
      Widget acceptButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
          BlocProvider.of<GetItemBloc>(context).add(FetchGetItem());
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
                  child: Lottie.asset("assets/lottie/basket.json")),
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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ThemeColor.backgroundColor,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: BlocListener<CartTransactionBloc, CartTransactionState>(
            listener: (context, state) {
              if (state is AddToCartSucess) {
                BlocProvider.of<GetItemBloc>(context).add(FetchGetItem());
              }

              if (state is CartTransactionSuccess) {
                BlocProvider.of<GetItemBloc>(context).add(FetchGetItem());
              }
            },
            child: BlocListener<GetItemBloc, GetItemState>(
              listener: (context, state) {},
              child: Stack(
                children: [
                  Container(
                    height: height * 0.5,
                    width: width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/transaction_bg.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: height * 0.32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Transaction",
                          style: ThemeText.dashboardHeader
                              .copyWith(color: ThemeColor.whiteColor),
                        ),
                        Text(
                          "Silahkan pilih barangnya",
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            width: width,
                            height: height * 0.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: ThemeColor.whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        ThemeColor.blackColor.withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 0,
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
                                    "Search",
                                    style: ThemeText.regular,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: searchController,
                                    onChanged: (value) {
                                      BlocProvider.of<GetItemBloc>(context)
                                          .add(SearchItem(itemName: value));
                                    },
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              BlocProvider.of<GetItemBloc>(
                                                      context)
                                                  .add(SearchItem(
                                                      itemName: searchController
                                                          .text));
                                            },
                                            icon: const Icon(Icons.search)),
                                        hintText: "Search Product Here",
                                        hintStyle: ThemeText.hintText,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 13, 8, 10),
                                        isDense: true,
                                        isCollapsed: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: ThemeColor
                                                  .activeTextFieldColor),
                                          borderRadius:
                                              BorderRadius.circular(17),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: height * 0.42,
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
                                        child: TransactionItemCard(
                                          addCart: items[index].addCart!,
                                          imageUrl: items[index].productImage,
                                          title: items[index].productName,
                                          price: items[index].price,
                                          press: () async {
                                            if (items[index].addCart == false) {
                                              setState(() {
                                                items[index].addCart = true;
                                                BlocProvider.of<
                                                            CartTransactionBloc>(
                                                        context)
                                                    .add(FetchCart(
                                                        value:
                                                            CartParamaterPost(
                                                                count: "1",
                                                                productName: items[
                                                                        index]
                                                                    .productName,
                                                                productPrice:
                                                                    items[index]
                                                                        .price,
                                                                itemsId: items[
                                                                        index]
                                                                    .id,
                                                                imageItem: items[
                                                                        index]
                                                                    .productImage,
                                                                priceTotal: ''),
                                                        addCart: true,
                                                        itemsId:
                                                            items[index].id));
                                                itemsId =
                                                    items[index].id.toString();
                                                listScreen.add(itemsId);
                                                listString =
                                                    listScreen.toString();
                                              });
                                            } else {
                                              setState(() {
                                                items[index].addCart = false;
                                                itemsId =
                                                    items[index].id.toString();

                                                BlocProvider.of<
                                                            CartTransactionBloc>(
                                                        context)
                                                    .add(DeleteCart(
                                                        itemsId: itemsId!,
                                                        addCart: false));

                                                listScreen.remove(itemsId);
                                                listString =
                                                    listScreen.toString();
                                              });
                                            }
                                          },
                                        ),
                                      );
                                    });
                              }
                              return Container(
                                  color: Colors.transparent,
                                  height: height * 0.42,
                                  width: width,
                                  child: Center(
                                    child: Lottie.asset(
                                        'assets/lottie/loading.json'),
                                  ));
                            },
                          ),
                        )
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
        ),
        bottomNavigationBar: (listString != "[]")
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
                              successDialog(
                                  "Add To Cart", "Add Item to Cart Success");
                              setState(() {
                                cartCount = 1;
                              });
                            },
                            child: Text("Add to cart",
                                style: ThemeText.buttonStartedText)),
                      ),
                      SizedBox(
                        height: height * 0.07,
                        width: width * 0.4,
                        child: (cartCount != 0)
                            ? ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(17))),
                                    backgroundColor: MaterialStateProperty.all(
                                        ThemeColor.primaryColor)),
                                onPressed: () {
                                  BlocProvider.of<CartTransactionBloc>(context)
                                      .add(GetCart());
                                  Navigator.pushNamed(context, cartPageScreen);
                                },
                                child: Text("Checkout",
                                    style: ThemeText.buttonStartedText))
                            : const SizedBox(),
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
