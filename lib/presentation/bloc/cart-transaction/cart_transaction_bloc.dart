import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sembako_bintang/domain/entity/transaction/cart/cart_entity.dart';
import 'package:sembako_bintang/domain/usecase/transaction/cart/cart_usecase.dart';

part 'cart_transaction_event.dart';
part 'cart_transaction_state.dart';

class CartTransactionBloc extends Bloc<CartTransactionEvent, CartTransactionState> {
  CartTransactionUseCase cartTransactionUseCase;
  CartTransactionBloc(this.cartTransactionUseCase) : super(CartTransactionInitial()) {
    on<FetchCart>((event, emit) async {
      emit(CartTransactionLoading());
      try {
        final result = await cartTransactionUseCase.execute();
        result.fold((failure){
          emit(CartTransactionFailed(message: failure.message));
        }, (response) {
          emit(CartTransactionDispose());
          emit(CartTransactionSuccess(value: response.oKContentCart!));
        });
      } catch (e) {
        
      }
    });
  }
}
