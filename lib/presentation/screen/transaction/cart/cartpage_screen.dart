import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/presentation/bloc/cart-transaction/cart_transaction_bloc.dart';
import 'package:sembako_bintang/presentation/screen/transaction/cart/widget/itemcard_transaction.dart';
import 'package:skeletons/skeletons.dart';

class CartPageScreen extends StatefulWidget {
  const CartPageScreen({super.key});

  @override
  State<CartPageScreen> createState() => _CartPageScreenState();
}

class _CartPageScreenState extends State<CartPageScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ThemeColor.backgroundColor,
      appBar: AppBar(
          backgroundColor: ThemeColor.backgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            "Keranjang belanja",
            style: ThemeText.dashboardHeader,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: BlocBuilder<CartTransactionBloc, CartTransactionState>(
          builder: (context, state) {
            if (state is CartTransactionSuccess) {
              var items = state.value!.cart;
              return ListView.builder(
                  itemCount: items!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ItemCartTransaction(
                            imageUrl: items[index].imageUrl,
                            title: items[index].title,
                            count: items[index].count,
                            price: items[index].price),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  });
            }
            return const SkeletonAvatar();
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: width,
          height: height * 0.16,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              padding: const EdgeInsets.all(20),
              height: height * 0.12,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: ThemeColor.whiteColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        NumberFormat.currency(symbol: 'IDR ', decimalDigits: 0)
                            .format(int.tryParse("27000")),
                        style: ThemeText.regularBold.copyWith(fontSize: 16),
                      ),
                      Text(
                        "Total Harga",
                        style: ThemeText.dashboardSubHeader,
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: height * 0.07,
                      width: width * 0.35,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ThemeColor.primaryColor),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(17)))),
                          onPressed: () {
                            Navigator.pushNamed(context, qrPageScreen);
                          },
                          child: Text(
                            "Checkout",
                            style: ThemeText.buttonStartedText,
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
