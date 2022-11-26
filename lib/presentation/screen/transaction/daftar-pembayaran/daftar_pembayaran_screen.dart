// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
// import 'package:sembako_bintang/data/utils/themes/color.dart';
// import 'package:sembako_bintang/data/utils/themes/text.dart';
// import 'package:sembako_bintang/domain/entity/transaction/data-transaction/data_transaction_entity.dart';
// import 'package:sembako_bintang/domain/usecase/transaction/data-transaction/data_transaction_usecase.dart';
// import 'package:sembako_bintang/presentation/bloc/data-transaction/data_transaction_bloc.dart';
// import 'package:sembako_bintang/presentation/screen/transaction/daftar-pembayaran/detail_pembayaran_screen.dart';
// import 'package:skeletons/skeletons.dart';

// class DaftarPembayaranScreen extends StatefulWidget {
//   const DaftarPembayaranScreen({super.key});

//   @override
//   State<DaftarPembayaranScreen> createState() => _DaftarPembayaranScreenState();
// }

// class _DaftarPembayaranScreenState extends State<DaftarPembayaranScreen>
//     with SingleTickerProviderStateMixin {
//   TabController? controller;
//   List<DataTransactionEntity> unPaidData = [];
//   List<DataTransactionEntity> paidData = [];

//   @override
//   void initState() {
//     controller = TabController(length: 2, vsync: this);
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   void dispose() {
//     controller!.dispose();
//     // TODO: implement dispose
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;

//     Widget pendingPage() =>
//         BlocBuilder<DataTransactionBloc, DataTransactionState>(
//           builder: (context, state) {
//             unPaidData = [];
//             if (state is DataTransactionSuccess) {
//               var items = state.value;
//               var check = items!
//                   .where((element) => element.status!.contains("Unpaid"))
//                   .toList();

//               for (var data in check) {
//                 unPaidData.add(data);
//               }
//               unPaidData.sort(
//                   ((a, b) => a.transactionDate!.compareTo(b.transactionDate!)));

//               return ListView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: state.value!
//                       .where((element) => element.status!.contains("Unpaid"))
//                       .length,
//                   itemBuilder: ((context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: ((context) => DetailPembayaranScreen(
//                                       data: unPaidData[index].data,
//                                       orderId: unPaidData[index].orderId!,
//                                       priceTotal: unPaidData[index].totalPrice!,
//                                       transactionDate:
//                                           unPaidData[index].transactionDate!,
//                                     ))));
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 5),
//                         height: height * 0.15,
//                         width: width,
//                         decoration: BoxDecoration(
//                             color: ThemeColor.whiteColor,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: ThemeColor.blackColor.withOpacity(0.2),
//                                 offset: const Offset(0, 2),
//                                 blurRadius: 1,
//                                 spreadRadius: 0,
//                               )
//                             ]),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(
//                               height: height * 0.15,
//                               width: width * 0.35,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                   top: 20,
//                                   bottom: 20,
//                                   left: 10,
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Order #${unPaidData[index].orderId} ",
//                                       style: ThemeText.regularBold,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "Number of items",
//                                           style: ThemeText.regularBold,
//                                         ),
//                                         const SizedBox(
//                                           width: 2,
//                                         ),
//                                         Text(
//                                           unPaidData[index]
//                                               .data
//                                               .length
//                                               .toString(),
//                                           style: ThemeText.regular,
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: height * 0.15,
//                               width: width * 0.23,
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Align(
//                                   alignment: Alignment.bottomRight,
//                                   child: Text(
//                                     NumberFormat.currency(
//                                             decimalDigits: 0, symbol: 'IDR ')
//                                         .format(int.tryParse(
//                                             unPaidData[index].totalPrice!)),
//                                     style: ThemeText.regularBold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: height * 0.15,
//                               width: width * 0.32,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 20, bottom: 15, right: 10),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       unPaidData[index].transactionTime!,
//                                       style: ThemeText.regularBold,
//                                     ),
//                                     SizedBox(
//                                       height: height * 0.05,
//                                       width: width * 0.28,
//                                       child: ElevatedButton(
//                                           style: ButtonStyle(
//                                               shape: MaterialStateProperty.all(
//                                                   RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               17))),
//                                               backgroundColor:
//                                                   MaterialStateProperty.all(
//                                                       ThemeColor
//                                                           .unpaidButtonColor)),
//                                           onPressed: () {},
//                                           child: Text(
//                                             "Unpaid",
//                                             style: ThemeText.buttonStartedText,
//                                           )),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   }));
//             }
//             return SizedBox(
//               width: width,
//               height: height,
//               child: const SkeletonAvatar(),
//             );
//           },
//         );

//     Widget completedPage() =>
//         BlocBuilder<DataTransactionBloc, DataTransactionState>(
//           builder: (context, state) {
//             paidData = [];

//             if (state is DataTransactionSuccess) {
//               var items = state.value;
//               var check = items!
//                   .where((element) => element.status!.contains("Paid"))
//                   .toList();
//               for (var data in check) {
//                 paidData.add(data);
//               }

//               paidData.sort(
//                   ((a, b) => a.transactionDate!.compareTo(b.transactionDate!)));

//               return ListView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: state.value!
//                       .where((element) => element.status!.contains("Paid"))
//                       .length,
//                   itemBuilder: ((context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: ((context) => DetailPembayaranScreen(
//                                       data: paidData[index].data,
//                                       orderId: paidData[index].orderId!,
//                                       priceTotal: paidData[index].totalPrice!,
//                                       transactionDate:
//                                           paidData[index].transactionDate!,
//                                     ))));
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 5),
//                         height: height * 0.15,
//                         width: width,
//                         decoration: BoxDecoration(
//                             color: ThemeColor.whiteColor,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: ThemeColor.blackColor.withOpacity(0.2),
//                                 offset: const Offset(0, 2),
//                                 blurRadius: 1,
//                                 spreadRadius: 0,
//                               )
//                             ]),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(
//                               height: height * 0.15,
//                               width: width * 0.35,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                   top: 20,
//                                   bottom: 20,
//                                   left: 10,
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Order #${paidData[index].orderId}",
//                                       style: ThemeText.regularBold,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "Number of items",
//                                           style: ThemeText.regularBold,
//                                         ),
//                                         Text(
//                                           paidData[index]
//                                               .data
//                                               .length
//                                               .toString(),
//                                           style: ThemeText.regular,
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: height * 0.15,
//                               width: width * 0.23,
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Align(
//                                   alignment: Alignment.bottomRight,
//                                   child: Text(
//                                     NumberFormat.currency(
//                                             decimalDigits: 0, symbol: 'IDR ')
//                                         .format(int.tryParse(
//                                             paidData[index].totalPrice!)),
//                                     style: ThemeText.regularBold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: height * 0.15,
//                               width: width * 0.3,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 20, bottom: 15, right: 10),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       paidData[index].transactionTime!,
//                                       style: ThemeText.regularBold,
//                                     ),
//                                     SizedBox(
//                                       height: height * 0.05,
//                                       width: width * 0.28,
//                                       child: ElevatedButton(
//                                           style: ButtonStyle(
//                                               shape: MaterialStateProperty.all(
//                                                   RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               17))),
//                                               backgroundColor:
//                                                   MaterialStateProperty.all(
//                                                       ThemeColor
//                                                           .paidButtonColor)),
//                                           onPressed: () {},
//                                           child: Text(
//                                             "Paid",
//                                             style: ThemeText.buttonStartedText,
//                                           )),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   }));
//             }
//             return SizedBox(
//               width: width,
//               height: height,
//               child: const SkeletonAvatar(),
//             );
//           },
//         );

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         toolbarHeight: height * 0.14,
//         elevation: 0,
//         backgroundColor: ThemeColor.backgroundColor,
//         title: Center(
//           child: Text(
//             "Daftar Pembayaran",
//             style: ThemeText.dashboardHeader,
//           ),
//         ),
//         bottom: TabBar(
//             indicatorColor: ThemeColor.blackColor,
//             padding: const EdgeInsets.symmetric(horizontal: 60),
//             controller: controller,
//             isScrollable: false,
//             labelColor: ThemeColor.blackColor,
//             labelStyle: ThemeText.regular,
//             // ignore: prefer_const_literals_to_create_immutables
//             tabs: [
//               const Tab(
//                 text: "Pending",
//               ),
//               const Tab(
//                 text: "Completed",
//               ),
//             ]),
//       ),
//       body: TabBarView(
//         controller: controller,
//         children: [
//           pendingPage(),
//           completedPage(),
//         ],
//       ),
//       bottomNavigationBar: SizedBox(
//         height: height * 0.2,
//         width: width,
//         child: Center(
//           child: SizedBox(
//             height: height * 0.09,
//             width: width * 0.65,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton(
//                   style: ButtonStyle(
//                       shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(17))),
//                       backgroundColor:
//                           MaterialStateProperty.all(ThemeColor.primaryColor)),
//                   onPressed: () {
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, homepageScreen, (route) => false);
//                   },
//                   child: Text(
//                     "Halaman Utama",
//                     style: ThemeText.buttonStartedText,
//                   )),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/presentation/bloc/data-transaction/data_transaction_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/get-item/get_item_bloc.dart';
import 'package:sembako_bintang/presentation/screen/transaction/daftar-pembayaran/detail_pembayaran_screen.dart';
import 'package:skeletons/skeletons.dart';

class DaftarPembayaranScreen extends StatefulWidget {
  const DaftarPembayaranScreen({super.key});

  @override
  State<DaftarPembayaranScreen> createState() => _DaftarPembayaranScreenState();
}

class _DaftarPembayaranScreenState extends State<DaftarPembayaranScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: height * 0.14,
        elevation: 0,
        backgroundColor: ThemeColor.backgroundColor,
        title: Center(
          child: Text(
            "Daftar Pembayaran",
            style: ThemeText.dashboardHeader,
          ),
        ),
      ),
      body: BlocBuilder<DataTransactionBloc, DataTransactionState>(
        builder: (context, state) {
          if (state is DataTransactionSuccess) {
            var items = state.value;

            items!.sort(((a, b) => ("${b.transactionDate!}${b.transactionTime}")
                .compareTo("${a.transactionDate!}${a.transactionTime}")));

            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => DetailPembayaranScreen(
                                    data: items[index].data,
                                    orderId: items[index].orderId!,
                                    priceTotal: items[index].totalPrice!,
                                    transactionDate:
                                        items[index].transactionDate!,
                                  ))));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      height: height * 0.15,
                      width: width,
                      decoration: BoxDecoration(
                          color: ThemeColor.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: ThemeColor.blackColor.withOpacity(0.2),
                              offset: const Offset(0, 2),
                              blurRadius: 1,
                              spreadRadius: 0,
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: height * 0.15,
                            width: width * 0.35,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                bottom: 20,
                                left: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order #${items[index].orderId}",
                                    style: ThemeText.regularBold,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Number of items",
                                        style: ThemeText.regularBold,
                                      ),
                                      Text(
                                        items[index].data.length.toString(),
                                        style: ThemeText.regular,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.15,
                            width: width * 0.3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 15, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    items[index].transactionTime!,
                                    style: ThemeText.regularBold,
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                            decimalDigits: 0, symbol: 'IDR ')
                                        .format(int.tryParse(
                                            items[index].totalPrice!)),
                                    style: ThemeText.regularBold,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }));
          }
          return SizedBox(
            width: width,
            height: height,
            child: const SkeletonAvatar(),
          );
        },
      ),
      bottomNavigationBar: SizedBox(
        height: height * 0.2,
        width: width,
        child: Center(
          child: SizedBox(
            height: height * 0.09,
            width: width * 0.65,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17))),
                      backgroundColor:
                          MaterialStateProperty.all(ThemeColor.primaryColor)),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, homepageScreen, (route) => false);
                  },
                  child: Text(
                    "Halaman Utama",
                    style: ThemeText.buttonStartedText,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
