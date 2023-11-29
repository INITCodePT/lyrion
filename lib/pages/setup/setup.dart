import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lyrion/pages/lyrion.dart';
import 'package:lyrion/util/data/local.dart';
import 'package:lyrion/util/widgets/main.dart';

class Setup extends StatelessWidget {
  const Setup({super.key});

  @override
  Widget build(BuildContext context) {
    //Pages
    final List<PageViewModel> introPages = [
      //Welcome
      PageViewModel(
        title: "Welcome to Lyrion!",
        body: "Simply Listen.",
      ),
    ];

    //UI
    return Scaffold(
      appBar: MainWidgets(context: context).appBar(
        title: const Text("Welcome to Lyrion"),
        allowBack: false,
      ),
      body: SafeArea(
        child: IntroductionScreen(
          pages: introPages,
          done: const Text("Let's Go!"),
          next: const Text("Next"),
          back: const Text("Back"),
          showDoneButton: true,
          showBackButton: true,
          onDone: () async {
            //Set Setup as Complete
            await LocalData.setData(box: "setup", data: {"status": true});

            //Go Home
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (context) => const Lyrion()),
                (route) => false,
              );
            }
          },
        ),
      ),
    );
  }
}
