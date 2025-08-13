import 'package:bloc/bloc.dart';
import 'pics_event.dart';
import 'pics_state.dart';
import '../../repositories/pics_repository.dart';

class PicsBloc extends Bloc<PicsEvent, PicsState> {
  final PicsRepository repository;
  PicsBloc({required this.repository}) : super(PicsInitial()) {
    on<FetchPics>(_onFetchPics);
  }

  Future<void> _onFetchPics(FetchPics event, Emitter<PicsState> emit) async {
    emit(PicsLoadInProgress());
    try {
      final pics = await repository.fetchPics(limit: event.limit);
      emit(PicsLoadSuccess(pics));
    } catch (e) {
      emit(PicsLoadFailure(e.toString()));
    }
  }
}
