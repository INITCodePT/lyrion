import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lyrion/util/data/local.dart';
import 'package:lyrion/util/models/artist.dart';
import 'package:lyrion/util/models/song.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key});

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying>
    with SingleTickerProviderStateMixin {
  ///Current Song
  Song? nowPlaying;

  ///Current Song Status
  bool? playingState;

  ///Get Current Playing Song
  Future<void> getCurrentPlayingSong() async {
    //Debug Song
    final debugSong = Song(
      image: "https://img.youtube.com/vi/cW8VLC9nnTo/0.jpg",
      name: "What Was I Made For?",
      artist: Artist(
        name: "Billie Eilish",
        image:
            "https://upload.wikimedia.org/wikipedia/commons/7/78/BillieEilishO2160622_%2811_of_45%29_%2852152972296%29_%28cropped_2%29.jpg",
        genres: [
          "pop",
          "dark pop",
          "electropop",
          "emo pop",
          "experimental pop",
          "goth pop",
          "indie pop",
          "teen pop",
          "alt pop",
        ],
      ),
      length: 240000,
    ).toJSON();

    //Saved Current Song
    final currentSong = LocalData.boxData(box: "playing")["data"] ?? debugSong;
    final songPlaying = LocalData.boxData(box: "playing")["status"] ?? false;

    //Parse into Song Object
    final song = Song.fromJSON(currentSong);

    //Set Current Song & State
    nowPlaying = song;
    playingState = songPlaying;
  }

  @override
  void initState() {
    super.initState();

    //Get Current Song
    getCurrentPlayingSong();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SizedBox(
        height: 100.0,
        width: double.infinity,
        child: Card(
          color: const Color(0xFF232234),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: nowPlaying != null
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      //Image
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(nowPlaying!.image),
                      ),

                      //Song & Artist
                      Expanded(
                        child: ListTile(
                          title: Text(
                            nowPlaying!.name,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(nowPlaying!.artist.name),
                        ),
                      ),

                      //Play & Pause
                      IconButton(
                        onPressed: () {
                          setState(() {
                            playingState = !(playingState ?? false);
                          });
                        },
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 80),
                          child: Icon(
                            playingState ?? false
                                ? FontAwesome5Solid.pause
                                : FontAwesome5Solid.play,
                            size: 24.0,
                            key: ValueKey<bool>(playingState ?? false),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: Text(
                    "No Song Playing",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
        ),
      ),
    );
  }
}
