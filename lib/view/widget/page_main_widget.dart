import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:quotable_app/view/constants/methods.dart';
import 'package:quotable_app/view_model/bloc/quote_bloc.dart';
import 'package:screenshot/screenshot.dart';
import 'package:lottie/lottie.dart';

class MainDetailsPageWidget extends StatefulWidget {
  ScreenshotController screenshotController;
  FlutterTts ftts;

  MainDetailsPageWidget(this.screenshotController, this.ftts, {super.key});

  @override
  State<MainDetailsPageWidget> createState() => _MainDetailsPageWidgetState();
}

class _MainDetailsPageWidgetState extends State<MainDetailsPageWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white, width: 2),
          image: DecorationImage(image: Method().getImage(), fit: BoxFit.cover),
          color: Colors.blueGrey),
      child: BlocBuilder<QuoteBloc, QuoteState>(
        builder: (context, state) {
          if (state is QuoteLoading) {
            return Center(
              child: Lottie.asset(
                'assets/anim/loading.json',
              ),
            );
          }
          if (state is QuoteError) {
            return Center(
              child: Lottie.asset(
                'assets/anim/networkeror.json',
              ),
            );
          }
          if (state is QuoteSuccess) {
            return Padding(
              padding:  EdgeInsets.all(size.height * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        overflow: TextOverflow.fade,
                        "''${state.quote.content!}''",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            backgroundColor: Colors.black26),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.fade,
                      state.quote.author!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          backgroundColor: Colors.black26),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () async {
                          Method().showSnackBar(
                            "This quote has been saved",
                            context,
                          );
                          final image =
                              await widget.screenshotController.capture();
                          if (image == null) return;
                          // await Method().saveImage(image);
                          await Method().saveAndShare(image);
                        },
                        icon: Icon(Icons.share,
                            color: Colors.white, size: size.height * 0.1),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black26),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          Method().showSnackBar(
                            "This quote has been copied",
                            context,
                          );
                          // ignore: prefer_const_constructors
                          await Clipboard.setData(ClipboardData(
                              text:
                                  "${state.quote.content} \n\n ${state.quote.author}\n\n"
                                  "More quotes : https://play.google.com/store/apps/details?id=uz.muslimsoft.quotable.quotable_app"));
                        },
                        icon: Icon(Icons.copy,
                            color: Colors.white, size: size.height * 0.1),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black26),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          //your custom configuration
                          await widget.ftts.setLanguage("en-US");
                          await widget.ftts.setSpeechRate(0.3); //speed of speech
                          await widget.ftts.setVolume(1.0); //volume of speech
                          await widget.ftts.setPitch(0.6); //pitch of sound

                          //play text to speech
                          var result = await widget.ftts.speak(
                              "${state.quote.content.toString()} . ${state.quote.author.toString()}");
                          print("Gapirdi");
                          if (result == 1) {
                            print("Gapirdi");
                          } else {
                            print("Gapirmadi");
                          }
                        },
                        icon: Icon(Icons.record_voice_over,
                            color: Colors.white, size: size.height * 0.1),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black26),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Lottie.asset(
                'assets/anim/loading.json',
              ),
            );
          }
        },
      ),
    );
  }
}
