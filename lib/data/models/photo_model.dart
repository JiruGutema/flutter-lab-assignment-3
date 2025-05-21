
class Photo {
  final int albumId;
  final int id;
  final String title;

  Photo({required this.albumId, required this.id, required this.title});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
    );
  }
}