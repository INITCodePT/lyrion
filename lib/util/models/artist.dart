///Artist
class Artist {
  ///Name
  final String name;

  ///Image
  final String image;

  ///Genres
  final List<String> genres;

  ///Artist
  Artist({required this.name, required this.image, required this.genres});

  ///`Artist` to JSON
  Map<String, dynamic> toJSON() {
    return {
      "name": name,
      "image": image,
      "genres": genres,
    };
  }

  ///`Artist` from JSON
  factory Artist.fromJSON(Map<String, dynamic> json) {
    return Artist(
      name: json["name"],
      image: json["image"],
      genres: (json["genres"] as List).cast<String>(),
    );
  }
}
