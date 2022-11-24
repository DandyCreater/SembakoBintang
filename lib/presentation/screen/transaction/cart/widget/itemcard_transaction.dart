import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sembako_bintang/data/model/transaction/cart/cart_responses_model.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/presentation/bloc/cart-transaction/cart_transaction_bloc.dart';

class ItemCartTransaction extends StatefulWidget {
  String? id;
  String? itemsId;
  String? imageUrl;
  String? title;
  String? count;
  String? price;

  ItemCartTransaction(
      {required this.id,
      required this.itemsId,
      required this.imageUrl,
      required this.title,
      required this.count,
      required this.price,
      super.key});

  @override
  State<ItemCartTransaction> createState() => _ItemCartTransactionState();
}

class _ItemCartTransactionState extends State<ItemCartTransaction> {
  int? itemPrice = 0;
  int? itemCount = 0;

  setCondition() {
    itemPrice = int.tryParse(widget.price!);
    itemCount = int.tryParse(widget.count!);
  }

  plusItem() {
    setState(() {
      itemCount = itemCount! + 1;
    });
    BlocProvider.of<CartTransactionBloc>(context).add(UpdateItemCart(
        value: CartParamaterPost(
          count: itemCount.toString(),
          imageItem: widget.imageUrl,
          itemsId: widget.itemsId,
          priceTotal: (itemCount! * itemPrice!).toString(),
          productName: widget.title,
          productPrice: widget.price,
        ),
        itemsId: widget.id));
  }

  minusItem() {
    setState(() {
      itemCount = itemCount! - 1;
    });
    BlocProvider.of<CartTransactionBloc>(context).add(UpdateItemCart(
        value: CartParamaterPost(
          count: itemCount.toString(),
          imageItem: widget.imageUrl,
          itemsId: widget.itemsId,
          priceTotal: (itemCount! * itemPrice!).toString(),
          productName: widget.title,
          productPrice: widget.price,
        ),
        itemsId: widget.id));
  }

  zeroCount(String text) {
    if (text == "0") {
      BlocProvider.of<CartTransactionBloc>(context)
          .add(DeleteItemCart(id: widget.id, itemsId: widget.itemsId));

      return "0";
    } else {
      text = text;
      return text;
    }
  }

  @override
  void initState() {
    setCondition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocListener<CartTransactionBloc, CartTransactionState>(
      listener: (context, state) {
        if (state is DeleteCheckOutCartSuccess) {
          BlocProvider.of<CartTransactionBloc>(context).add(GetCart());
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: width,
        height: height * 0.14,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: ThemeColor.whiteColor,
            boxShadow: [
              BoxShadow(
                  color: ThemeColor.blackColor.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(0, 1))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: height,
              width: width * 0.2,
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 70,
                  width: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.imageUrl!),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            SizedBox(
              height: height,
              width: width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title!,
                    style: ThemeText.regular,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          minusItem();
                        },
                        icon: const Icon(Icons.remove_circle),
                        color: ThemeColor.optionColor,
                      ),
                      Text(
                        // itemCount.toString(),
                        zeroCount(itemCount.toString()),
                        style: ThemeText.regular,
                      ),
                      IconButton(
                        onPressed: () {
                          plusItem();
                        },
                        icon: const Icon(Icons.add_circle),
                        color: ThemeColor.optionColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height,
              width: 100,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      NumberFormat.currency(decimalDigits: 0, symbol: 'IDR ')
                          .format(int.tryParse(widget.price!)),
                      style: ThemeText.regularBold,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: IconButton(
                          onPressed: () {
                            BlocProvider.of<CartTransactionBloc>(context).add(
                                DeleteItemCart(
                                    id: widget.id, itemsId: widget.itemsId));
                          },
                          icon: Icon(
                            Icons.highlight_off,
                            color: ThemeColor.blackColor.withOpacity(0.2),
                          ),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
