import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

///YouTube Audio
class YouTubeAudio {
  ///YouTube Client
  static final YoutubeExplode _youtube = YoutubeExplode();

  ///Get Audio Stream as Bytes by `youtubeID`
  static Future<Uint8List> audioStreamAsBytes(
      {required String youtubeID}) async {
    //Stream Manifest
    final manifest = await _youtube.videos.streamsClient.getManifest(youtubeID);

    //Highest Quality
    final highQualityStream = manifest.audioOnly.withHighestBitrate();

    //Stream URI
    final uri = highQualityStream.url;

    //Return Stream as Bytes
    return _audioBytes(uri: uri);
  }

  ///Get Audio Bytes
  static Future<Uint8List> _audioBytes({required Uri uri}) async {
    //Response
    final response = await http.get(uri);

    //Check Response
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception("Failed to Load Audio Data");
    }
  }
}
