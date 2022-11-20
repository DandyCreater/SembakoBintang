import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/presentation/bloc/barang-transaction/barang_transaction_bloc.dart';
import 'package:sembako_bintang/presentation/screen/items/edit-item/edit_item_barang_screen.dart';
import 'package:sembako_bintang/presentation/screen/transaction/transaction-menu/widget/item_card.dart';
import 'package:skeletons/skeletons.dart';

class ItemEditScreen extends StatefulWidget {
  const ItemEditScreen({super.key});

  @override
  State<ItemEditScreen> createState() => _ItemEditScreenState();
}

class _ItemEditScreenState extends State<ItemEditScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: ThemeColor.backgroundColor,
        title: Text(
          "Edit Barang",
          style: ThemeText.dashboardHeader,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Search",
                      style: ThemeText.regular
                          .copyWith(color: ThemeColor.dashboardTextTitleColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          isDense: true,
                          isCollapsed: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 15, 4, 15),
                          hintText: "Nama Barang",
                          hintStyle: ThemeText.regular.copyWith(
                              color: ThemeColor.blackColor.withOpacity(0.2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: const BorderSide(
                                  color:
                                      ThemeColor.dashboardTextSubTitleColor))),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: height * 0.36,
                child:
                    BlocBuilder<BarangTransactionBloc, BarangTransactionState>(
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const EditItemBarangScreen(
                                  itemName: "Pocari Sweat", price: "12000"))));
                    },
                    child: Text("Edit", style: ThemeText.buttonStartedText)),
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
                    onPressed: () {},
                    child: Text("Hapus", style: ThemeText.buttonStartedText)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
