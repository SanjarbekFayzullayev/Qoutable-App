import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quotable_app/model/quote.dart';
import 'package:quotable_app/model/repositories/random_repository.dart';

part 'quote_event.dart';

part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  QuoteBloc() : super(QuoteInitial()) {
    on<QuoteEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetRandom>(_mapGetRandomEventToState);

    on<GetQuoteList>((event, emit) {});

    on<GetAuthorList>((event, emit) {});
  }

  void _mapGetRandomEventToState(GetRandom event,
      Emitter<QuoteState> emit) async {
    emit(QuoteLoading());
    try {
      final quote = await RandomRepository().fetchRandom();
      emit(QuoteSuccess(quote));
    } catch (e) {
      print(e.toString());
      emit(QuoteError(e.toString()));
    }
  }
}
