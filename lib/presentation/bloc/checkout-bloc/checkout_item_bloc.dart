import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sembako_bintang/data/model/transaction/checkout/checkout_response_model.dart';
import 'package:sembako_bintang/domain/usecase/transaction/checkout/checkout_usecase.dart';

part 'checkout_item_event.dart';
part 'checkout_item_state.dart';

class CheckoutItemBloc extends Bloc<CheckoutItemEvent, CheckoutItemState> {
  final CheckOutItemUseCase checkOutItemUseCase;
  final ClearCartItemsUseCase clearCartItemsUseCase;
  CheckoutItemBloc(this.checkOutItemUseCase, this.clearCartItemsUseCase)
      : super(CheckoutItemInitial()) {
    on<FetchCheckOut>((event, emit) async {
      emit(CheckoutItemLoading());
      try {
        final result = await checkOutItemUseCase.execute(event.value!);

        result.fold((failure) {
          emit(CheckoutItemFailed(message: failure.message));
        }, (response) {
          emit(CheckoutItemSuccess());
        });
      } catch (e) {
        debugPrint("Bloc Check Out Error $e");
        emit(CheckoutItemFailed(message: "BLOC CHECK OUT ERROR $e"));
      }
    });

    on<ClearCartData>((event, emit) async {
      emit(CheckoutItemLoading());
      try {
        final result = await clearCartItemsUseCase.execute();

        result.fold((failure) {
          emit(ClearCartDataFailed(message: failure.message));
        }, (response) {
          emit(ClearCartDataSuccess());
        });
      } catch (e) {
        debugPrint("Bloc Clear Cart Data Check Out Error $e");
        emit(ClearCartDataFailed(
            message: "BLOC CLEAR CART DATA CHECK OUT ERROR $e"));
      }
    });
  }
}
