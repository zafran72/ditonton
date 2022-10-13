import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tv.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTv _searchTv;

  TvSearchBloc(this._searchTv) : super(TvSearchEmpty()) {
    on<OnTvQueryChanged>((event, emit) async {
      final query = event.query;

      emit(TvSearchLoading());
      final result = await _searchTv.execute(query);

      result.fold(
        (failure) {},
        (data) {
          emit(TvSearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
