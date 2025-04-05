import 'package:flutter/material.dart';
import '../repositories/publicacion_repository.dart';
import '../models/publicacion.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  final PublicacionRepository _repository = PublicacionRepository();
  List<Publicacion> _publicaciones = [];
  bool _isLoading = true;
  bool _isGridView = false; // Alternar entre lista y grid
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cargarPublicaciones();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _cargarPublicaciones() async {
    try {
      final publicaciones = await _repository.obtenerTodas();
      setState(() {
        _publicaciones = publicaciones;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _mostrarError('Error al cargar publicaciones: $e');
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Lógica para cargar más datos (paginación)
    }
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), backgroundColor: Colors.red),
    );
  }

  void _alternarVista() {
    setState(() => _isGridView = !_isGridView);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todas las Publicaciones'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: _alternarVista,
            tooltip: _isGridView ? 'Vista lista' : 'Vista grid',
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: _cargarPublicaciones,
                child: _isGridView ? _buildGridView() : _buildListView(),
              ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_upward),
        onPressed:
            () => _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _publicaciones.length,
      itemBuilder: (context, index) {
        final publicacion = _publicaciones[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          elevation: 2,
          child: ListTile(
            title: Text(
              publicacion.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              publicacion.body.length > 100
                  ? '${publicacion.body.substring(0, 100)}...'
                  : publicacion.body,
            ),
            leading: CircleAvatar(child: Text(publicacion.id.toString())),
            onTap: () => _mostrarDetalle(publicacion),
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemCount: _publicaciones.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final publicacion = _publicaciones[index];
        return Card(
          elevation: 3,
          child: InkWell(
            onTap: () => _mostrarDetalle(publicacion),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#${publicacion.id}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    publicacion.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      publicacion.body,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _mostrarDetalle(Publicacion publicacion) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.7,
            maxChildSize: 0.9,
            minChildSize: 0.5,
            builder:
                (_, controller) => SingleChildScrollView(
                  controller: controller,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          publicacion.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        Text(publicacion.body),
                        const SizedBox(height: 16),
                        Text(
                          'User ID: ${publicacion.userId}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }
}
