import 'package:get_it/get_it.dart';
import 'package:sembako_bintang/data/datasources/local_data_sources.dart';
import 'package:sembako_bintang/data/datasources/remote_data_sources.dart';
import 'package:sembako_bintang/data/repository/data_repository_impl.dart';
import 'package:sembako_bintang/domain/repository/domain_repository.dart';
import 'package:sembako_bintang/domain/usecase/dashboard/menu_usecase.dart';
import 'package:sembako_bintang/domain/usecase/items/get_items_barang_usecase.dart';
import 'package:sembako_bintang/domain/usecase/items/tambah_barang_usecase.dart';
import 'package:sembako_bintang/domain/usecase/report/filter_data_bydate_usecase.dart';
import 'package:sembako_bintang/domain/usecase/transaction/cart/cart_usecase.dart';
import 'package:sembako_bintang/domain/usecase/transaction/checkout/checkout_usecase.dart';
import 'package:sembako_bintang/domain/usecase/transaction/data-transaction/data_transaction_usecase.dart';
import 'package:sembako_bintang/presentation/bloc/cart-transaction/cart_transaction_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/checkout-bloc/checkout_item_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/data-transaction/data_transaction_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/get-item/get_item_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/menu-dashboard/menu_dashboard_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/reports-filter/reports_filter_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/tambah-barang/tambah_barang_bloc.dart';

final sl = GetIt.instance;

Future<void> init(String baseUrl) async {
  //Bloc
  sl.registerFactory(() => MenuDashboardBloc(sl()));
  sl.registerFactory(() => CartTransactionBloc(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => TambahBarangBloc(sl()));
  sl.registerFactory(() => GetItemBloc(
        sl(),
        sl(),
        sl(),
        sl(),
      ));
  sl.registerFactory(() => CheckoutItemBloc(sl(), sl()));
  sl.registerFactory(() => DataTransactionBloc(sl()));
  sl.registerFactory(() => ReportsFilterBloc(sl()));

  //UseCase Area
  //Dashboard Usecase
  sl.registerLazySingleton(() => MenuDashboardUseCase(sl()));

  //Item Usecase
  sl.registerLazySingleton(() => CartTransactionUseCase(sl()));
  sl.registerLazySingleton(() => TambahBarangUseCase(sl()));
  sl.registerLazySingleton(() => GetItemUseCase(sl()));
  sl.registerLazySingleton(() => SearchItemUseCase(sl()));
  sl.registerLazySingleton(() => DeleteItemUseCase(sl()));
  sl.registerLazySingleton(() => UpdateDataItemUseCase(sl()));

  //Transaction Usecase
  sl.registerLazySingleton(() => DeleteCartTransactionUseCase(sl()));
  sl.registerLazySingleton(() => GetCartItemUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCartCheckOutUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCartDataUseCase(sl()));
  sl.registerLazySingleton(() => CheckOutItemUseCase(sl()));
  sl.registerLazySingleton(() => ClearCartItemsUseCase(sl()));
  sl.registerLazySingleton(() => DataTransactionUseCase(sl()));

  //Reports UseCase
  sl.registerLazySingleton(() => FilterDataByDateUseCase(sl()));

  //Repository
  sl.registerLazySingleton<DomainRepository>(() =>
      DataRepositoryImpl(localDataSources: sl(), remoteDataSources: sl()));

  //Data Source
  sl.registerLazySingleton<LocalDataSources>(() => LocalDataSourcesImpl());
  sl.registerLazySingleton<RemoteDataSources>(() => RemoteDataSourcesImpl());
}
