import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';

class AudioPlayerManager {
  static final Map<String, AudioPlayer> _players = {};

  ///Get Audio Player by `playerID`
  static AudioPlayer getPlayer(String playerID) {
    return _players.putIfAbsent(
      playerID,
      () => AudioPlayer(playerId: playerID),
    );
  }

  ///Check Playing Status
  static Future<bool> checkIfPlaying({required String playerID}) async {
    //Player
    final player = getPlayer(playerID);

    //Playing Status
    final playingStatus = player.state;

    //Return Based on Playing State
    return playingStatus == PlayerState.playing;
  }

  ///Play from URL
  static Future<AudioPlayer> playFromURL({
    required String name,
    required String url,
  }) async {
    //Audio Player
    final audioPlayer = getPlayer(name);

    //Play Audio - via URL
    await audioPlayer.play(UrlSource(url), volume: 1.0);

    //Return Player
    return audioPlayer;
  }

  ///Play from Bytes
  static Future<AudioPlayer> playFromBytes({
    required String name,
    required Uint8List bytes,
  }) async {
    //Audio Player
    final audioPlayer = getPlayer(name);

    //Play Audio - via URL
    await audioPlayer.play(BytesSource(bytes), volume: 1.0);

    //Return Player
    return audioPlayer;
  }

  ///Set AudioPlayer Volume
  static Future<void> setPlayerVolume({
    required String playerID,
    required double volume,
  }) async {
    //Player
    final player = getPlayer(playerID);

    //Set Volume
    await player.setVolume(volume / 100);
  }

  ///Stop Player by ID
  static Future<void> stopPlayer({required String playerID}) async {
    //Player
    final player = getPlayer(playerID);

    //Stop Player
    await player.stop();
  }

  ///Stop All AudioPlayers
  static void stopAllPlayers() async {
    for (final player in _players.values) {
      await player.stop();
    }
  }

  ///Update Loop Status by `playerID`
  static void updateLoopStatus(String playerID, bool loopStatus) {
    final player = _players[playerID];

    if (player != null) {
      player.setReleaseMode(loopStatus ? ReleaseMode.loop : ReleaseMode.stop);
    }
  }
}
