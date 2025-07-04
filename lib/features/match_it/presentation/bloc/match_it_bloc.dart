import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'match_it_event.dart';
part 'match_it_state.dart';

class MatchItBloc extends Bloc<MatchItEvent, MatchItState> {
  MatchItBloc() : super(MatchItInitial()) {
    on<MatchItEvent>((event, emit) {});
  }
}
