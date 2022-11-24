part of 'cart_transaction_bloc.dart';

abstract class CartTransactionState extends Equatable {
  const CartTransactionState();

  @override
  List<Object> get props => [];
}

class CartTransactionInitial extends CartTransactionState {}

class CartTransactionLoading extends CartTransactionState {}

class CartTransactionDispose extends CartTransactionState {}

class CartTransactionSuccess extends CartTransactionState {
  @override
  // TODO: implement props
  List<Object> get props => super.props;
}

class CartTransactionFailed extends CartTransactionState {
  final String? message;

  const CartTransactionFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}

class AddToCartSucess extends CartTransactionState {
  @override
  // TODO: implement props
  List<Object> get props => super.props;
}

class AddToCartFailed extends CartTransactionState {
  final String? message;

  const AddToCartFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}

class GetCartSuccess extends CartTransactionState {
  final List<CartEntity> cartItem;

  const GetCartSuccess({required this.cartItem});

  @override
  // TODO: implement props
  List<Object> get props => [cartItem];
}

class GetCartFailed extends CartTransactionState {
  final String? message;

  const GetCartFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}

class DeleteCheckOutCartSuccess extends CartTransactionState {}

class DeleteCheckOutCartFailed extends CartTransactionState {
  final String? message;

  const DeleteCheckOutCartFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}

class UpdateCartItemSuccess extends CartTransactionState {}

class UpdateCartItemFailed extends CartTransactionState {
  final String? message;

  const UpdateCartItemFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}
