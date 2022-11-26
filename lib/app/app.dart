import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sembako_bintang/app/route.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/presentation/bloc/cart-transaction/cart_transaction_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/checkout-bloc/checkout_item_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/data-transaction/data_transaction_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/get-item/get_item_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/menu-dashboard/menu_dashboard_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/midtrans-transaction/midtrans_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/reports-filter/reports_filter_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/tambah-barang/tambah_barang_bloc.dart';

import 'injection_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final menuDashboardBloc = sl<MenuDashboardBloc>()
      ..add(FetchMenuDashboard());
    final cartTransactionBloc = sl<CartTransactionBloc>();
    final tambahBarangBloc = sl<TambahBarangBloc>();
    final listBarangBloc = sl<GetItemBloc>()..add(FetchGetItem());
    final checkOutBloc = sl<CheckoutItemBloc>();
    final dataTransactionBloc = sl<DataTransactionBloc>();
    final filterDatabyDateBloc = sl<ReportsFilterBloc>();
    final midTransBloc = sl<MidtransBloc>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => menuDashboardBloc),
        BlocProvider(create: (_) => cartTransactionBloc),
        BlocProvider(create: (_) => tambahBarangBloc),
        BlocProvider(create: (_) => listBarangBloc),
        BlocProvider(create: (_) => checkOutBloc),
        BlocProvider(create: (_) => dataTransactionBloc),
        BlocProvider(create: (_) => filterDatabyDateBloc),
        BlocProvider(create: (_) => midTransBloc)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: splashScreen,
        onGenerateRoute: Routes().onGenerateRoute,
      ),
    );
  }
}
