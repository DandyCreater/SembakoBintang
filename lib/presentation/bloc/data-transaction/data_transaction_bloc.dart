import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sembako_bintang/domain/entity/transaction/data-transaction/data_transaction_entity.dart';
import 'package:sembako_bintang/domain/usecase/transaction/data-transaction/data_transaction_usecase.dart';

part 'data_transaction_event.dart';
part 'data_transaction_state.dart';

class DataTransactionBloc
    extends Bloc<DataTransactionEvent, DataTransactionState> {
  final DataTransactionUseCase dataTransactionUseCase;
  final CancelTransactionPaymentUseCase cancelTransactionPayment;
  final FinishTransactionPaymentUseCase finishTransactionPaymentUseCase;
  DataTransactionBloc(this.dataTransactionUseCase, this.cancelTransactionPayment, this.finishTransactionPaymentUseCase)
      : super(DataTransactionInitial()) {
    on<FetchDataTransaction>((event, emit) async {
      emit(DataTransactionLoading());

      try {
        final result = await dataTransactionUseCase.execute();

        result.fold((failure) {
          emit(DataTransactionFailed(message: failure.message));
        }, (response) {
          emit(DataTransactionSuccess(value: response));
        });
      } catch (e) {
        debugPrint("BLOC GET DATA TRANSACTION ERROR $e");
        emit(DataTransactionFailed(
            message: "BLOC GET DATA TRANSACTION ERROR $e"));
      }
    });

     on<CancelPaymentTransaction>((event, emit) async {
      emit(DataTransactionLoading());

      try {
        final result = await cancelTransactionPayment.execute(event.itemsId!);

        result.fold((failure) {
          emit(CancelPaymentTransactionFailed(message: failure.message));
        }, (response) {
          emit(CancelPaymentTransactionSuccess());
        });
      } catch (e) {
        debugPrint("BLOC DELETE DATA TRANSACTION ERROR $e");
        emit(CancelPaymentTransactionFailed(
            message: "BLOC DELETE DATA TRANSACTION ERROR $e"));
      }
    });

       on<FinishPaymentTransaction>((event, emit) async {
      emit(DataTransactionLoading());

      try {
        final result = await finishTransactionPaymentUseCase.execute(event.itemsId!);

        result.fold((failure) {
          emit(FinishPaymentTransactionFailed(message: failure.message));
        }, (response) {
          emit(FinishPaymentTransactionSuccess());
        });
      } catch (e) {
        debugPrint("BLOC FINISIH PAYMENT TRANSACTION ERROR $e");
        emit(FinishPaymentTransactionFailed(
            message: "BLOC FINISIH PAYMENT TRANSACTION ERROR $e"));
      }
    });
  }
}
