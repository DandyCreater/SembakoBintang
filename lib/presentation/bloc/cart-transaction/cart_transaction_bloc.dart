import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sembako_bintang/data/model/transaction/cart/cart_responses_model.dart';
import 'package:sembako_bintang/domain/entity/transaction/cart/cart_entity.dart';
import 'package:sembako_bintang/domain/usecase/transaction/cart/cart_usecase.dart';
import 'package:sembako_bintang/presentation/bloc/get-item/get_item_bloc.dart';

part 'cart_transaction_event.dart';
part 'cart_transaction_state.dart';

class CartTransactionBloc
    extends Bloc<CartTransactionEvent, CartTransactionState> {
  final CartTransactionUseCase cartTransactionUseCase;
  final DeleteCartTransactionUseCase deleteCartTransactionUseCase;
  final GetCartItemUseCase getCartItemUseCase;
  final DeleteCartCheckOutUseCase deleteCartCheckOutUseCase;
  final UpdateCartDataUseCase updateCartDataUseCase;

  CartTransactionBloc(
      this.cartTransactionUseCase,
      this.deleteCartTransactionUseCase,
      this.getCartItemUseCase,
      this.deleteCartCheckOutUseCase,
      this.updateCartDataUseCase)
      : super(CartTransactionInitial()) {
    on<FetchCart>((event, emit) async {
      emit(CartTransactionLoading());
      try {
        final result = await cartTransactionUseCase.execute(
            event.value!, event.addCart!, event.itemsId!);
        result.fold((failure) {
          emit(AddToCartFailed(message: failure.message));
        }, (response) {
          emit(AddToCartSucess());
        });
      } catch (e) {
        emit(AddToCartFailed(message: "BLOC  At CART Transaction Error $e"));
      }
    });

    on<DeleteCart>((event, emit) async {
      // emit(CartTransactionLoading());
      try {
        final result = await deleteCartTransactionUseCase.execute(
            event.itemsId, event.addCart);

        result.fold((failure) {
          emit(CartTransactionFailed(message: failure.message));
        }, (response) {
          emit(CartTransactionSuccess());
        });
      } catch (e) {
        emit(CartTransactionFailed(
            message: "BLOC Delete CART Transaction Error $e"));
      }
    });

    on<GetCart>((event, emit) async {
      // emit(CartTransactionLoading());
      try {
        final result = await getCartItemUseCase.execute();

        result.fold((failure) {
          emit(GetCartFailed(message: failure.message));
        }, (response) {
          emit(GetCartSuccess(cartItem: response));
        });
      } catch (e) {
        emit(GetCartFailed(message: "BLOC Delete CART Transaction Error $e"));
      }
    });

    on<DeleteItemCart>((event, emit) async {
      emit(CartTransactionLoading());
      try {
        final result =
            await deleteCartCheckOutUseCase.execute(event.id!, event.itemsId!);
        result.fold((failure) {
          emit(DeleteCheckOutCartFailed(message: failure.message));
        }, (response) {
          emit(DeleteCheckOutCartSuccess());
        });
      } catch (e) {
        emit(DeleteCheckOutCartFailed(
            message: "BLOC  At CART Transaction Error $e"));
      }
    });

    on<UpdateItemCart>((event, emit) async {
      emit(CartTransactionLoading());
      try {
        final result =
            await updateCartDataUseCase.execute(event.value!, event.itemsId!);
        result.fold((failure) {
          emit(UpdateCartItemFailed(message: failure.message));
        }, (response) {
          emit(UpdateCartItemSuccess());
        });
      } catch (e) {
        emit(UpdateCartItemFailed(
            message: "BLOC  At CART Transaction Error $e"));
      }
    });
  }
}
