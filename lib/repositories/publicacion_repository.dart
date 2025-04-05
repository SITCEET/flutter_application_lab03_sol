import '../models/publicacion.dart';
import '../services/api_service.dart';

class PublicacionRepository {
  final ApiService _apiService;

  // Inyectamos el ApiService por constructor (mejor para testing)
  PublicacionRepository({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  // ---------------------- OPERACIONES GET ----------------------

  /// Obtiene todas las publicaciones
  Future<List<Publicacion>> obtenerTodas() async {
    try {
      return await _apiService.getPublicaciones();
    } catch (e) {
      throw Exception('Error al obtener publicaciones: $e');
    }
  }

  /// Obtiene una publicación por ID
  Future<Publicacion> obtenerPorId(int id) async {
    try {
      return await _apiService.getPublicacion(id);
    } catch (e) {
      throw Exception('Error al obtener publicación $id: $e');
    }
  }

  /// Obtiene comentarios de una publicación (dos implementaciones)
  Future<List<dynamic>> obtenerComentarios(
    int postId, {
    bool usarEndpointDirecto = true,
  }) async {
    try {
      return usarEndpointDirecto
          ? await _apiService.getPublicacionComments(postId)
          : await _apiService.getCommentsByPublicacionId(postId);
    } catch (e) {
      throw Exception('Error al obtener comentarios: $e');
    }
  }

  // ---------------------- OPERACIONES POST/PUT/PATCH/DELETE ----------------------

  /// Crea una nueva publicación
  Future<Publicacion> crear(Publicacion publicacion) async {
    try {
      return await _apiService.createPublicacion(publicacion);
    } catch (e) {
      throw Exception('Error al crear publicación: $e');
    }
  }

  /// Actualiza toda la publicación (PUT)
  Future<Publicacion> actualizarCompleta(
    int id,
    Publicacion publicacion,
  ) async {
    try {
      return await _apiService.updatePublicacion(id, publicacion);
    } catch (e) {
      throw Exception('Error al actualizar publicación $id: $e');
    }
  }

  /// Actualización parcial (PATCH)
  Future<Publicacion> actualizarParcial(
    int id,
    Map<String, dynamic> cambios,
  ) async {
    try {
      return await _apiService.patchPublicacion(id, cambios);
    } catch (e) {
      throw Exception('Error al actualizar parcialmente publicación $id: $e');
    }
  }

  /// Elimina una publicación
  Future<bool> eliminar(int id) async {
    try {
      return await _apiService.deletePublicacion(id);
    } catch (e) {
      throw Exception('Error al eliminar publicación $id: $e');
    }
  }

  // ---------------------- MÉTODOS ADICIONALES ÚTILES ----------------------

  /// Obtiene publicaciones paginadas
  Future<List<Publicacion>> obtenerPagina(int pagina, {int limite = 10}) async {
    try {
      final todas = await _apiService.getPublicaciones();
      return todas.skip((pagina - 1) * limite).take(limite).toList();
    } catch (e) {
      throw Exception('Error al obtener página $pagina: $e');
    }
  }

  /// Busca publicaciones por título
  Future<List<Publicacion>> buscarPorTitulo(String query) async {
    try {
      final todas = await _apiService.getPublicaciones();
      return todas
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      throw Exception('Error al buscar publicaciones: $e');
    }
  }
}
