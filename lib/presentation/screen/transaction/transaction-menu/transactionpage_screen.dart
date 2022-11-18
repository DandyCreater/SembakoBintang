import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/presentation/bloc/barang-transaction/barang_transaction_bloc.dart';
import 'package:sembako_bintang/presentation/screen/transaction/transaction-menu/widget/item_card.dart';
import 'package:skeletons/skeletons.dart';

class TransactionPageScreen extends StatefulWidget {
  const TransactionPageScreen({super.key});

  @override
  State<TransactionPageScreen> createState() => _TransactionPageScreenState();
}

class _TransactionPageScreenState extends State<TransactionPageScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ThemeColor.backgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: height * 0.5,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/transaction_bg.png"),
                    // scale: 0.1,
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
                              color: ThemeColor.blackColor.withOpacity(0.2),
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
                              decoration: InputDecoration(
                                  hintText: "Search Product Here",
                                  hintStyle: ThemeText.hintText,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(10, 10, 8, 10),
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
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: height * 0.36,
                    child: BlocBuilder<BarangTransactionBloc,
                        BarangTransactionState>(
                      builder: (context, state) {
                        if (state is BarangTransactionSuccess) {
                          var items = state.value!.barang!;
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: items.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: TransactionItemCard(
                                      imageUrl: items[index].imageUrl,
                                      title: items[index].title,
                                      price: items[index].price),
                                );
                              }));
                        }
                        return const SkeletonAvatar();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
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
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17))),
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColor.primaryColor)),
                    onPressed: () {},
                    child: Text("Add to cart",
                        style: ThemeText.buttonStartedText)),
              ),
              SizedBox(
                height: height * 0.07,
                width: width * 0.4,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17))),
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColor.primaryColor)),
                    onPressed: () {
                      Navigator.pushNamed(context, cartPageScreen);
                    },
                    child:
                        Text("Checkout", style: ThemeText.buttonStartedText)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
