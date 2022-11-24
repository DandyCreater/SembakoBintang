part of 'get_item_bloc.dart';

abstract class GetItemEvent extends Equatable {
  const GetItemEvent();

  @override
  List<Object> get props => [];
}

class FetchGetItem extends GetItemEvent {
  @override
  // TODO: implement props
  List<Object> get props => super.props;
}

class SearchItem extends GetItemEvent {
  final String itemName;

  const SearchItem({required this.itemName});

  @override
  // TODO: implement props
  List<Object> get props => [itemName];
}

class DeleteItem extends GetItemEvent {
  final String itemsId;

  const DeleteItem({required this.itemsId});

  @override
  // TODO: implement props
  List<Object> get props => [itemsId];
}

class UpdateDataItem extends GetItemEvent {
  final ItemsEntity? dataItem;
  final File? imageFile;

  const UpdateDataItem({required this.dataItem, required this.imageFile});

  @override
  // TODO: implement props
  List<Object> get props => [dataItem!, imageFile!];
}
