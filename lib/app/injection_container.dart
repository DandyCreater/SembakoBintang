import 'package:get_it/get_it.dart';
import 'package:sembako_bintang/data/datasources/local_data_sources.dart';
import 'package:sembako_bintang/data/repository/data_repository_impl.dart';
import 'package:sembako_bintang/domain/repository/domain_repository.dart';
import 'package:sembako_bintang/domain/usecase/dashboard/menu_usecase.dart';
import 'package:sembako_bintang/domain/usecase/transaction/barang/barang_usecase.dart';
import 'package:sembako_bintang/domain/usecase/transaction/cart/cart_usecase.dart';
import 'package:sembako_bintang/presentation/bloc/barang-transaction/barang_transaction_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/cart-transaction/cart_transaction_bloc.dart';
import 'package:sembako_bintang/presentation/bloc/menu-dashboard/menu_dashboard_bloc.dart';

final sl = GetIt.instance;

Future<void> init(String baseUrl) async {
  //Bloc
  sl.registerFactory(() => MenuDashboardBloc(sl()));
  sl.registerFactory(() => BarangTransactionBloc(sl()));
  sl.registerFactory(() => CartTransactionBloc(sl()));

  //UseCase
  sl.registerLazySingleton(() => MenuDashboardUseCase(sl()));
  sl.registerLazySingleton(() => BarangTransactionUseCase(sl()));
  sl.registerLazySingleton(() => CartTransactionUseCase(sl()));

  //Repository
  sl.registerLazySingleton<DomainRepository>(
      () => DataRepositoryImpl(localDataSources: sl()));

  //Data Source
  sl.registerLazySingleton<LocalDataSources>(() => LocalDataSourcesImpl());
}
