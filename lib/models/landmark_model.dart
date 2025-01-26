class Landmark {
    String name;
    String description;
    String image;
    String location;

    Landmark({
        required this.name,
        required this.description,
        required this.image,
        required this.location,
    });

    factory Landmark.fromJson(Map<String, dynamic> json) => Landmark(
        name: json["name"],
        description: json["description"],
        image: json["image"],
        location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "image": image,
        "location": location,
    };
}
