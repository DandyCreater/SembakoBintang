part of 'tambah_barang_bloc.dart';

abstract class TambahBarangEvent extends Equatable {
  const TambahBarangEvent();

  @override
  List<Object> get props => [];
}

class InputBarang extends TambahBarangEvent {
  final String? price;
  final String? productName;
  final File? imageFile;

  const InputBarang(
      {required this.price,
      required this.productName,
      required this.imageFile});

  @override
  // TODO: implement props
  List<Object> get props => [price!, productName!, imageFile!];
}
