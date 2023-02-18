class Place {
  String name;
  String img;
  String description;
  String location;

  Place({
    required this.name,
    required this.img,
    required this.description,
    required this.location,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
        name: json["name"],
        img: json["img"],
        description: json["description"],
        location: json["location"]);
  }
}
