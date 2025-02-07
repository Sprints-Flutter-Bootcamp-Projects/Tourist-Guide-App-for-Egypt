class Landmark {
  String name;
  String description;
  String image;
  String location;
  double? lat;
  double? lng;

  Landmark({
    required this.name,
    required this.description,
    required this.image,
    required this.location,
    required this.lat,
    required this.lng,
  });

  factory Landmark.fromJson(Map<String, dynamic> json) => Landmark(
        name: json["name"],
        description: json["description"],
        image: json["image"],
        location: json["location"],
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "image": image,
        "location": location,
        "lat": lat,
        "lng": lng,
      };
}
