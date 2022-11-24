import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sembako_bintang/domain/entity/transaction/data-transaction/data_transaction_entity.dart';
import 'package:sembako_bintang/domain/usecase/report/filter_data_bydate_usecase.dart';

part 'reports_filter_event.dart';
part 'reports_filter_state.dart';

class ReportsFilterBloc extends Bloc<ReportsFilterEvent, ReportsFilterState> {
  final FilterDataByDateUseCase filterDataByDateUseCase;
  ReportsFilterBloc(this.filterDataByDateUseCase)
      : super(ReportsFilterInitial()) {
    on<StartFilterByDate>((event, emit) async {
      emit(ReportsFilterLoading());

      try {
        final result = await filterDataByDateUseCase.execute(
            event.startDate!, event.endDate!);
        result.fold((failure) {
          emit(ReportsFilterFailed(message: failure.message));
        }, (response) {
          emit(ReportsFilterSuccess(value: response));
        });
      } catch (e) {
        debugPrint("BLOC FILTER BY DATE ERROR $e");
        emit(ReportsFilterFailed(message: "BLOC FILTER BY DATE ERROR $e"));
      }
    });
  }
}
