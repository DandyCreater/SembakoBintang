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
  DataTransactionBloc(this.dataTransactionUseCase)
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
  }
}
