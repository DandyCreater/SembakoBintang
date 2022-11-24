part of 'get_item_bloc.dart';

abstract class GetItemState extends Equatable {
  const GetItemState();

  @override
  List<Object> get props => [];
}

class GetItemInitial extends GetItemState {}

class GetItemLoading extends GetItemState {}

class GetItemDisposes extends GetItemState {}

class GetItemSuccess extends GetItemState {
  final List<ItemsEntity>? itemsEntity;

  const GetItemSuccess({required this.itemsEntity});

  @override
  // TODO: implement props
  List<Object> get props => [itemsEntity!];
}

class GetItemFailed extends GetItemState {
  final String? message;

  const GetItemFailed(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}

class DeleteItemSuccess extends GetItemState{}

class DeleteItemFailed extends GetItemState{
  final String? message;

  const DeleteItemFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}

class UpdateDataItemSuccess extends GetItemState{}

class UpdateDataItemFailed extends GetItemState{
  final String? message;

  const UpdateDataItemFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}