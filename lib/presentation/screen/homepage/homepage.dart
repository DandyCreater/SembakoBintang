import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/presentation/bloc/data-transaction/data_transaction_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/menu-dashboard/menu_dashboard_bloc.dart';
import 'package:sembako_bintang/presentation/screen/homepage/widget/card_homepage.dart';
import 'package:skeletons/skeletons.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ThemeColor.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: BlocListener<DataTransactionBloc, DataTransactionState>(
          listener: (context, state) {
            if (state is DataTransactionSuccess) {
              Navigator.pushNamed(context, daftarPembayaranScreen);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Halo,\nSelamat Datang!",
                      style: ThemeText.dashboardHeader,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Semoga harimu menyenangkan!",
                      style: ThemeText.dashboardSubHeader,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: height * 0.5,
                  child: BlocBuilder<MenuDashboardBloc, MenuDashboardState>(
                    builder: (context, state) {
                      if (state is MenuDashboardSuccess) {
                        var items = state.value.menu;
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: items!.length,
                            itemBuilder: ((context, index) {
                              return Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: CardHomePage(
                                    imageUrl: items[index].imageUrl,
                                    title: items[index].title,
                                    subtitle: items[index].subTitle,
                                    press: () {
                                      Navigator.pushNamed(context,
                                          items[index].routeName.toString());
                                    }),
                              );
                            }));
                      }
                      return const SkeletonAvatar();
                    },
                  )),
              SizedBox(
                height: height * 0.1,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: height * 0.07,
                    width: width * 0.6,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17))),
                            backgroundColor: MaterialStateProperty.all(
                                ThemeColor.primaryColor)),
                        onPressed: () {
                          BlocProvider.of<DataTransactionBloc>(context)
                              .add(FetchDataTransaction());
                        },
                        child: Text(
                          "Daftar Pembayaran",
                          style: ThemeText.buttonStartedText,
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
