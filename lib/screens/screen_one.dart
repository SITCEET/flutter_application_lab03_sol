import 'package:flutter/material.dart';
import '../repositories/publicacion_repository.dart';
import '../models/publicacion.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  final PublicacionRepository _repository = PublicacionRepository();
  final TextEditingController _idController = TextEditingController();
  Publicacion? _publicacion;
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _buscarPublicacion() async {
    final id = int.tryParse(_idController.text);

    if (id == null || id <= 0) {
      setState(() {
        _errorMessage = 'Ingrese un ID válido (número mayor a 0)';
        _publicacion = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _publicacion = null;
    });

    try {
      final publicacion = await _repository.obtenerPorId(id);
      setState(() {
        _publicacion = publicacion;
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Publicación inválida';
        _publicacion = null;
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Publicación'),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ingrese el ID de la publicación:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Ej: 1, 2, 3...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _buscarPublicacion,
                ),
              ),
              onSubmitted: (_) => _buscarPublicacion(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _buscarPublicacion,
              child: const Text('Buscar Publicación'),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_errorMessage.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.red[50],
                child: Text(
                  _errorMessage,
                  style: TextStyle(
                    color: Colors.red[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else if (_publicacion != null)
              _buildPublicacionCard()
            else
              const Text(
                'Ingrese un ID y presione buscar',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPublicacionCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _publicacion!.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(_publicacion!.body, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text(
              'ID: ${_publicacion!.id} | UserID: ${_publicacion!.userId}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
