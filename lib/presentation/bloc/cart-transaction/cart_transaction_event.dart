part of 'cart_transaction_bloc.dart';

abstract class CartTransactionEvent extends Equatable {
  const CartTransactionEvent();

  @override
  List<Object> get props => [];
}

class FetchCart extends CartTransactionEvent{
  @override
  // TODO: implement props
  List<Object> get props => super.props;
}