import 'package:lyrion/util/models/artist.dart';

///Song
class Song {
  ///Image
  final String image;

  ///Name
  final String name;

  ///Artist
  final Artist artist;

  ///Length
  final int length;

  ///YouTube ID
  final String youtubeID;

  ///Song
  Song({
    required this.image,
    required this.name,
    required this.artist,
    required this.length,
    required this.youtubeID,
  });

  ///`Song` from JSON
  factory Song.fromJSON(Map<String, dynamic> json) {
    return Song(
      image: json["image"],
      name: json["name"],
      artist: Artist.fromJSON(json["artist"]),
      length: json["length"],
      youtubeID: json["youtubeID"],
    );
  }

  ///`Song` to JSON
  Map<String, dynamic> toJSON() {
    return {
      "image": image,
      "name": name,
      "artist": artist.toJSON(),
      "length": length,
      "youtubeID": youtubeID,
    };
  }
}
