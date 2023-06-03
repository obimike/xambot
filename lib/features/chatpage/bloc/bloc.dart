import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  BlocBloc() : super(BlocState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<BlocState> emit) async {
    emit(state.clone());
  }
}
