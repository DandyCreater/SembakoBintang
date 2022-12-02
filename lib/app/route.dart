import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sembako_bintang/data/utils/helper/constanta_string.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';
import 'package:sembako_bintang/data/utils/themes/text.dart';
import 'package:sembako_bintang/presentation/screen/homepage/daftar_pembayaran_homepage.dart';
import 'package:sembako_bintang/presentation/screen/homepage/homepage.dart';
import 'package:sembako_bintang/presentation/screen/items/edit-item/item_edit_screen.dart';
import 'package:sembako_bintang/presentation/screen/items/itemspage_screen.dart';
import 'package:sembako_bintang/presentation/screen/items/tambah-item/tambah_barang_screen.dart';
import 'package:sembako_bintang/presentation/screen/report/report-page/detail_filter_report_screen.dart';
import 'package:sembako_bintang/presentation/screen/report/report-page/reportpage_screen.dart';
import 'package:sembako_bintang/presentation/screen/splashscreen/get_started.dart';
import 'package:sembako_bintang/presentation/screen/splashscreen/splashscreen.dart';
import 'package:sembako_bintang/presentation/screen/transaction/cart/cartpage_screen.dart';
import 'package:sembako_bintang/presentation/screen/transaction/daftar-pembayaran/daftar_pembayaran_screen.dart';
import 'package:sembako_bintang/presentation/screen/transaction/qr/qrpage_screen.dart';
import 'package:sembako_bintang/presentation/screen/transaction/transaction-menu/transactionpage_screen.dart';

class Routes {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      //Splash Area
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case getStartedScreen:
        return PageTransition(
            child: const GetStartedScreen(),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(seconds: 1));

      //Dashboard Area
      case homepageScreen:
        return MaterialPageRoute(
          builder: (_) => const HomePageScreen(),
        );
      case daftarPembayaranHomepageScreen:
        return MaterialPageRoute(
            builder: (_) => const DaftarPembayaranHomepage());

      //Transaction Area
      case transactionPageScreen:
        return MaterialPageRoute(
          builder: (_) => const TransactionPageScreen(),
        );
      case cartPageScreen:
        return MaterialPageRoute(
          builder: (_) => const CartPageScreen(),
        );
      // case qrPageScreen:
        // return MaterialPageRoute(
        //   builder: (_) => const QrPageScreen(),
        // );
      case daftarPembayaranScreen:
        return MaterialPageRoute(
          builder: (_) => const DaftarPembayaranScreen(),
        );

      //Items Area
      case itemsPageScreen:
        return MaterialPageRoute(
          builder: (_) => const ItemsPageScreen(),
        );
      case tambahBarangScreen:
        return MaterialPageRoute(
          builder: (_) => const TambahBarangScreen(),
        );
      case itemEditScreen:
        return MaterialPageRoute(
          builder: (_) => const ItemEditScreen(),
        );

      //Reports Page
      case reportPageScreen:
        return MaterialPageRoute(
          builder: (_) => const ReportPageScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              leading: InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: ThemeColor.primaryText,
                ),
                onTap: () => Navigator.pop(context),
              ),
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Error",
                style: ThemeText.regular,
              ),
              backgroundColor: Colors.white,
            ),
            body: Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                      child: Icon(Icons.error_rounded),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      child: Text(
                        "Halaman Sedang Dalam Pengerjaan",
                        style: ThemeText.regular,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        );
    }
  }
}
