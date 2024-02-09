part of 'quote_bloc.dart';

@immutable
abstract class QuoteEvent {
  const  QuoteEvent();
  @override

  List<Object?> get props =>[];

}

class GetRandom extends QuoteEvent{}
class GetQuoteList extends QuoteEvent{}
class GetAuthorList extends QuoteEvent{}
