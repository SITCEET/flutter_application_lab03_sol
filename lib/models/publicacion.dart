class Publicacion {
  final int userId;
  final int id;
  final String title;
  final String body;

  Publicacion({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  //Deserialización: Convierte el valor JSON a objeto Dart
  factory Publicacion.fromJson(Map<String, dynamic> json) {
    return Publicacion(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  //Serialización (Objeto Dart → JSON)
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'id': id,
    'title': title,
    'body': body,
  };
}
