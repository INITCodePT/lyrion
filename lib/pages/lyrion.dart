import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lyrion/util/widgets/main.dart';
import 'package:lyrion/util/widgets/playing.dart';

class Lyrion extends StatelessWidget {
  const Lyrion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainWidgets(context: context).appBar(
        centerTitle: false,
        allowBack: false,
        title: const Text(
          "Hi!",
          style: TextStyle(fontSize: 26.0),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {},
              tooltip: "Library",
              icon: const Icon(Ionicons.ios_library),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NowPlaying(),
    );
  }
}
