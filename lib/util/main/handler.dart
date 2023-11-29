import 'package:flutter/cupertino.dart';
import 'package:lyrion/pages/lyrion.dart';
import 'package:lyrion/pages/setup/setup.dart';
import 'package:lyrion/util/data/local.dart';

///Main Processes
class MainProcesses {
  ///Initialize Services
  static Future<void> init() async {
    //Ensure Widgets Binding is Initialized
    WidgetsFlutterBinding.ensureInitialized();

    //Local Data
    await LocalData.init();
  }

  ///Initial Route
  static Widget initialRoute() {
    //Setup Status
    final bool setupStatus = LocalData.boxData(box: "setup")["status"] ?? false;

    //Return Setup if Not Complete
    return setupStatus ? const Lyrion() : const Setup();
  }
}
