

import 'package:quotable_app/model/quote.dart';
import 'package:quotable_app/model/services/base_sevice.dart';
import 'package:quotable_app/model/services/random_service.dart';

class RandomRepository {
  final BaseService _randomService = RandomService();

  Future<Quote> fetchRandom() async {
    dynamic response = await _randomService.getResponse("/random");
    final details = Quote.fromJson(response);
    return details;
  }
}
