import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart' as just_audio;

class AudioPlayerManager {
  static final Map<String, AudioPlayer> _players = {};

  ///Get Audio Player by `playerID`
  static AudioPlayer getPlayer(String playerID) {
    return _players.putIfAbsent(
      playerID,
      () => AudioPlayer(),
    );
  }

  ///Check Playing Status
  static bool checkIfPlaying({required String playerID}) {
    //Player
    final player = getPlayer(playerID);

    //Playing Status
    final playingStatus = player.state;

    //Return Based on Playing State
    return playingStatus == PlayerState.playing;
  }

  ///Play from URL using just_audio
  static Future<AudioPlayer> playFromURL({
    required String name,
    required Uri uri,
  }) async {
    //Audio Player
    final audioPlayer = getPlayer(name);

    //Play
    await audioPlayer.play(UrlSource(uri.toString()));

    //Return Player
    return audioPlayer;
  }

  ///Play from URL (iOS)
  static Future<just_audio.AudioPlayer> playFromURLiOS({
    required String name,
    required Uri uri,
  }) async {
    //Audio Player
    final audioPlayer = just_audio.AudioPlayer();

    //Set Stream URL
    await audioPlayer.setUrl(uri.toString());

    //Play
    await audioPlayer.play();

    //Return Player
    return audioPlayer;
  }

  ///Play Web Stream
  static Future<AudioPlayer> playWebStream({
    required String name,
    required Uri uri,
  }) async {
    //Response
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      //Stream Bytes
      final streamBytes = response.bodyBytes;

      //Audio Player
      final audioPlayer = AudioPlayer();

      //Play
      audioPlayer.play(BytesSource(streamBytes));

      //Return Player
      return audioPlayer;
    } else {
      throw Exception("Failed to Load WebM Stream");
    }
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
      player.setReleaseMode(
        loopStatus ? ReleaseMode.loop : ReleaseMode.release,
      );
    }
  }
}
