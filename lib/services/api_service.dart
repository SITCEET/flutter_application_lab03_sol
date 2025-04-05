import 'dart:convert';
import 'package:flutter_application_lab03/models/publicacion.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'jsonplaceholder.typicode.com';

  // HEADERS COMUNES
  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  // ---------------------- MÉTODOS GET ----------------------

  /// Obtiene todas las publicaciones
  Future<List<Publicacion>> getPublicaciones() async {
    final uri = Uri.https(_baseUrl, '/posts');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Publicacion.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
  }

  /// Obtiene una publicación específica por ID
  Future<Publicacion> getPublicacion(int id) async {
    final uri = Uri.https(_baseUrl, '/posts/$id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Publicacion.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post $id: ${response.statusCode}');
    }
  }

  /// Obtiene los comentarios de una publicación específica
  Future<List<dynamic>> getPublicacionComments(int postId) async {
    final uri = Uri.https(_baseUrl, '/posts/$postId/comments');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
        'Failed to load comments for post $postId: ${response.statusCode}',
      );
    }
  }

  /// Obtiene comentarios filtrados por postId (versión alternativa)
  Future<List<dynamic>> getCommentsByPublicacionId(int postId) async {
    final uri = Uri.https(_baseUrl, '/comments', {'postId': '$postId'});
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
        'Failed to load comments by postId $postId: ${response.statusCode}',
      );
    }
  }

  // ---------------------- MÉTODOS POST/PUT/PATCH/DELETE ----------------------

  /// Crea una nueva publicación
  Future<Publicacion> createPublicacion(Publicacion publicacion) async {
    final uri = Uri.https(_baseUrl, '/posts');
    final response = await http.post(
      uri,
      headers: _headers,
      body: json.encode(publicacion.toJson()),
    );

    if (response.statusCode == 201) {
      return Publicacion.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create post: ${response.statusCode}');
    }
  }

  /// Actualiza toda una publicación (PUT)
  Future<Publicacion> updatePublicacion(int id, Publicacion publicacion) async {
    final uri = Uri.https(_baseUrl, '/posts/$id');
    final response = await http.put(
      uri,
      headers: _headers,
      body: json.encode(publicacion.toJson()),
    );

    if (response.statusCode == 200) {
      return Publicacion.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update post $id: ${response.statusCode}');
    }
  }

  /// Actualiza parcialmente una publicación (PATCH)
  Future<Publicacion> patchPublicacion(
    int id,
    Map<String, dynamic> updates,
  ) async {
    final uri = Uri.https(_baseUrl, '/posts/$id');
    final response = await http.patch(
      uri,
      headers: _headers,
      body: json.encode(updates),
    );

    if (response.statusCode == 200) {
      return Publicacion.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to patch post $id: ${response.statusCode}');
    }
  }

  /// Elimina una publicación
  Future<bool> deletePublicacion(int id) async {
    final uri = Uri.https(_baseUrl, '/posts/$id');
    final response = await http.delete(uri);

    return response.statusCode == 200;
  }
}
