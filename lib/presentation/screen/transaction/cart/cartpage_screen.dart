import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sembako_bintang/data/model/transaction/checkout/checkout_response_model.dart';
import 'package:sembako_bintang/data/model/transaction/midtrans/midtrans_response_model.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/helper/dialog.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/presentation/bloc/cart-transaction/cart_transaction_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/checkout-bloc/checkout_item_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/get-item/get_item_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/midtrans-transaction/midtrans_bloc.dart';
import 'package:sembako_bintang/presentation/screen/transaction/cart/widget/itemcard_transaction.dart';
import 'package:skeletons/skeletons.dart';

class CartPageScreen extends StatefulWidget {
  const CartPageScreen({super.key});

  @override
  State<CartPageScreen> createState() => _CartPageScreenState();
}

class _CartPageScreenState extends State<CartPageScreen> {
  final dialog = DialogHelper();
  int? itemQty = 0;
  int? finalPrice = 0;
  int? priceFinal = 0;
  List listPrice = [];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ThemeColor.backgroundColor,
        appBar: AppBar(
            backgroundColor: ThemeColor.backgroundColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  BlocProvider.of<GetItemBloc>(context).add(FetchGetItem());
                  Navigator.pushNamed(context, transactionPageScreen);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: ThemeColor.blackColor,
                )),
            title: Text(
              "Keranjang belanja",
              style: ThemeText.dashboardHeader,
            )),
        body: BlocListener<CartTransactionBloc, CartTransactionState>(
          listener: (context, state) {
            if (state is DeleteCheckOutCartSuccess) {
              setState(() {
                listPrice = [];
              });
              BlocProvider.of<CartTransactionBloc>(context).add(GetCart());
            }
            if (state is UpdateCartItemSuccess) {
              setState(() {
                listPrice = [];
              });
              BlocProvider.of<CartTransactionBloc>(context).add(GetCart());
            }
            if (state is GetItemSuccess) {
              setState(() {
                finalPrice = 0;
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: BlocBuilder<CartTransactionBloc, CartTransactionState>(
              builder: (context, state) {
                if (state is GetCartSuccess) {
                  var items = state.cartItem;
                  return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ItemCartTransaction(
                              imageUrl: items[index].imageItem,
                              title: items[index].productName,
                              count: items[index].count,
                              price: items[index].productPrice,
                              id: items[index].id,
                              itemsId: items[index].cartId,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
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
                    BlocListener<MidtransBloc, MidtransState>(
                      listener: (context, state) {
                        if(state is MidtransLoading){
                          dialog.loadingDialog(context, height, width);
                          Future.delayed(const Duration(seconds: 2));
                        }
                        if (state is MidtransSuccess) {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, qrPageScreen);
                        }
                      },
                      child: BlocListener<CheckoutItemBloc, CheckoutItemState>(
                        listener: (context, state) {
                          if (state is CheckoutItemSuccess) {
                            setState(() {
                              finalPrice = 0;
                            });
                            BlocProvider.of<MidtransBloc>(context)
                                .add(StartMidtransTransaction());
                            BlocProvider.of<CheckoutItemBloc>(context)
                                .add(ClearCartData());
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<CartTransactionBloc,
                                CartTransactionState>(
                              builder: (context, state) {
                                if (state is GetCartSuccess) {
                                  var items = state.cartItem;

                                  for (var i = 0; i < items.length; i++) {
                                    finalPrice =
                                        int.tryParse(items[i].finalPrice!);
                                    listPrice.add(finalPrice);
                                  }

                                  priceFinal = listPrice.reduce(
                                      ((value, element) => value + element));

                                  return Text(
                                    NumberFormat.currency(
                                            symbol: 'IDR ', decimalDigits: 0)
                                        .format(priceFinal),
                                    style: ThemeText.regularBold
                                        .copyWith(fontSize: 16),
                                  );
                                }
                                return SizedBox(
                                  width: width * 0.15,
                                  height: 20,
                                  child: const SkeletonAvatar(),
                                );
                              },
                            ),
                            Text(
                              "Total Harga",
                              style: ThemeText.dashboardSubHeader,
                            )
                          ],
                        ),
                      ),
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
                              BlocProvider.of<CheckoutItemBloc>(context).add(
                                  FetchCheckOut(
                                      value: CheckOutParameterPost(
                                          numberOfItems:
                                              listPrice.length.toString(),
                                          totalPrice: priceFinal.toString())));
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
      ),
    );
  }
}
