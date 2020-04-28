import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageIndexBloc extends Bloc<int, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(int newIndex) async* {
    yield newIndex;
  }
}