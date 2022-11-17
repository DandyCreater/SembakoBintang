import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sembako_bintang/domain/entity/dashboard/menu_entity.dart';
import 'package:sembako_bintang/domain/entity/transaction/barang/barang_entity.dart';
import 'package:sembako_bintang/domain/usecase/transaction/barang/barang_usecase.dart';

part 'barang_transaction_event.dart';
part 'barang_transaction_state.dart';

class BarangTransactionBloc
    extends Bloc<BarangTransactionEvent, BarangTransactionState> {
  BarangTransactionUseCase barangTransactionUseCase;
  BarangTransactionBloc(this.barangTransactionUseCase)
      : super(BarangTransactionInitial()) {
    on<FetchBarangTransaction>((event, emit) async {
      emit(BarangTransactionLoading());

      try {
        final result = await barangTransactionUseCase.execute();
        result.fold((failure){
          emit(BarangTransactionFailed(message: failure.message));
        } , (response) {
          emit(BarangTransactionDispose());
          emit(BarangTransactionSuccess(value: response.oKContentBarang!));
;        });
      } catch (e) {
        emit(BarangTransactionFailed(
            message: "BLOC BARANG TRANSACTION ERROR $e"));
      }
    });
  }
}
