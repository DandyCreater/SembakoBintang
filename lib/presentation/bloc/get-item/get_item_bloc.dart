import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sembako_bintang/data/model/transaction/cart/cart_responses_model.dart';
import 'package:sembako_bintang/domain/entity/items/items_entity.dart';
import 'package:sembako_bintang/domain/usecase/items/get_items_barang_usecase.dart';
import 'package:sembako_bintang/domain/usecase/transaction/cart/cart_usecase.dart';

part 'get_item_event.dart';
part 'get_item_state.dart';

class GetItemBloc extends Bloc<GetItemEvent, GetItemState> {
  final GetItemUseCase getItemUseCase;
  final SearchItemUseCase searchItemUseCase;
  final DeleteItemUseCase deleteItemUseCase;
  final UpdateDataItemUseCase updateDataItemUseCase;
  GetItemBloc(
    this.getItemUseCase,
    this.searchItemUseCase,
    this.deleteItemUseCase,
    this.updateDataItemUseCase,
  ) : super(GetItemInitial()) {
    on<FetchGetItem>((event, emit) async {
      emit(GetItemLoading());
      try {
        final result = await getItemUseCase.execute();
        result.fold((failure) {
          emit(GetItemFailed(failure.message));
        }, (response) {
          emit(GetItemDisposes());
          emit(GetItemSuccess(itemsEntity: response));
        });
      } catch (e) {
        emit(GetItemFailed("BLOC GET ITEM ERROR $e"));
      }
    });

    on<SearchItem>((event, emit) async {
      emit(GetItemLoading());
      try {
        final result = await searchItemUseCase.execute(event.itemName);

        result.fold((failure) {
          emit(GetItemFailed(failure.message));
        }, (response) {
          emit(GetItemDisposes());
          emit(GetItemSuccess(itemsEntity: response));
        });
      } catch (e) {
        emit(GetItemFailed("BLOC SEARCH ITEM ERROR $e"));
      }
    });

    on<DeleteItem>((event, emit) async {
      emit(GetItemLoading());
      try {
        final result = await deleteItemUseCase.execute(event.itemsId);
        result.fold((failure) {
          emit(DeleteItemFailed(message: failure.message));
        }, (response) {
          emit(DeleteItemSuccess());
        });
      } catch (e) {
        emit(DeleteItemFailed(message: 'BLOC DELETE ITEM ERROR $e'));
      }
    });

    on<UpdateDataItem>((event, emit) async {
      emit(GetItemLoading());
      try {
        final result = await updateDataItemUseCase.execute(
            event.dataItem!, event.imageFile!);

        result.fold((failure) {
          emit(UpdateDataItemFailed(message: failure.message));
        }, (response) {
          emit(UpdateDataItemSuccess());
        });
      } catch (e) {
        emit(UpdateDataItemFailed(message: 'BLOC UPDATE ITEM ERROR $e'));
      }
    });
  }
}
