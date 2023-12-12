import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_list/model/item_model.dart';

part 'item_event.dart';
part 'item_state.dart';
part 'item_bloc.freezed.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(const ItemState.initial()) {
    on<_Started>(_onStart);
  }
  FutureOr<void> _onStart(_Started event, Emitter<ItemState> emit) async {
    emit(const ItemState.loading());
    await event.list;
    if(event.list != null){
      emit(ItemState.loaded(event.list));
    }else{

    }
  }
}
