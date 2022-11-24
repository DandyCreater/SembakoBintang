part of 'cart_transaction_bloc.dart';

abstract class CartTransactionEvent extends Equatable {
  const CartTransactionEvent();

  @override
  List<Object> get props => [];
}

class FetchCart extends CartTransactionEvent {
  final CartParamaterPost? value;
  final String? itemsId;
  final bool? addCart;

  const FetchCart(
      {required this.value, required this.itemsId, required this.addCart});
  @override
  // TODO: implement props
  List<Object> get props => [value!, itemsId!, addCart!];
}

class DeleteCart extends CartTransactionEvent {
  final String itemsId;
  final bool addCart;

  const DeleteCart({required this.itemsId, required this.addCart});

  @override
  // TODO: implement props
  List<Object> get props => [itemsId, addCart];
}

class GetCart extends CartTransactionEvent {
  @override
  // TODO: implement props
  List<Object> get props => super.props;
}

class DeleteItemCart extends CartTransactionEvent {
  final String? itemsId;
  final String? id;

  const DeleteItemCart({required this.id, required this.itemsId});

  @override
  // TODO: implement props
  List<Object> get props => [id!, itemsId!];
}

class UpdateItemCart extends CartTransactionEvent{
  final CartParamaterPost? value;
  final String? itemsId;

  const UpdateItemCart({required this.value, required this.itemsId});

  @override
  // TODO: implement props
  List<Object> get props => [value!, itemsId!];
}