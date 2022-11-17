import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sembako_bintang/app/route.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/presentation/bloc/barang-transaction/barang_transaction_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/cart-transaction/cart_transaction_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/menu-dashboard/menu_dashboard_bloc.dart';

import 'injection_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final menuDashboardBloc = sl<MenuDashboardBloc>()
      ..add(FetchMenuDashboard());
    final barangTransactionBloc = sl<BarangTransactionBloc>()
      ..add(FetchBarangTransaction());
    final cartTransactionBloc = sl<CartTransactionBloc>()..add(FetchCart());
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => menuDashboardBloc),
        BlocProvider(create: (_) => barangTransactionBloc),
        BlocProvider(create: (_) => cartTransactionBloc),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: splashScreen,
        onGenerateRoute: Routes().onGenerateRoute,
      ),
    );
  }
}
