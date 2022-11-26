import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:sembako_bintang/data/model/transaction/midtrans/midtrans_response_model.dart';
import 'package:sembako_bintang/data/utils/helper/failure.dart';
import 'package:sembako_bintang/domain/entity/midtrans/midtrans_entity.dart';
import 'package:sembako_bintang/domain/usecase/transaction/midtrans/midtrans_usecase.dart';

part 'midtrans_event.dart';
part 'midtrans_state.dart';

class MidtransBloc extends Bloc<MidtransEvent, MidtransState> {
  final MidtransUseCase midtransUseCase;
  MidtransBloc(this.midtransUseCase) : super(MidtransInitial()) {
    on<StartMidtransTransaction>((event, emit) async {
      emit(MidtransLoading());

      try {
        final result =
            await midtransUseCase.execute();

        result.fold((failure) {
          emit(MidtransFailed(message: failure.message));
        }, (response) {
          emit(MidtransSuccess(value: response));
        });
      } catch (e) {
        debugPrint("BLOC MIDTRANS ERROR $e");
        emit(MidtransFailed(message: "BLOC MIDTRANS ERROR $e"));
      }
    });
  }
}
