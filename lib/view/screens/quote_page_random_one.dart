import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:quotable_app/view/widget/page_main_widget.dart';
import 'package:quotable_app/view_model/bloc/quote_bloc.dart';
import 'package:screenshot/screenshot.dart';

class QuotePageRandomOne extends StatefulWidget {
  QuotePageRandomOne({Key? key}) : super(key: key);

  @override
  State<QuotePageRandomOne> createState() => _QuotePageRandomOneState();
}
class _QuotePageRandomOneState extends State<QuotePageRandomOne> {
  FlutterTts ftts = FlutterTts();
  final ScreenshotController _screenshotController = ScreenshotController();
  @override
  void initState() {
    super.initState();
    context.read<QuoteBloc>().add(GetRandom());
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotController,
      child: MainDetailsPageWidget(_screenshotController, ftts),
    );
  }
}
