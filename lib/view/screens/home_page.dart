import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:quotable_app/view/screens/quote_page_random_one.dart';
import 'package:quotable_app/view/screens/quote_page_random_tue.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List cards = [QuotePageRandomOne(), const QuotePageRandomTue()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color(0xFF474859),
              Color(0xFF393945),
              Color(0xFF1F2A36),
            ])),
        child: CardSwiper(
          cardsCount: cards.length,
          cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
          cards[index],
        ),
      ),
    );
  }
}
