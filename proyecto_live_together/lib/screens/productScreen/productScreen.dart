import 'package:flutter/material.dart';
import '../../service/productScreen_service.dart';

class ProductScreen extends StatelessWidget {
  final int id;
  final int? idUsuario; // Puede ser nulo

  ProductScreen({required this.id, this.idUsuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Producto', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ProductoService.obtenerDetallesProducto(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error al cargar el producto.'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('Producto no encontrado.'));
          }

          final producto = snapshot.data!;
          
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Carrusel de imágenes
                FutureBuilder<List<String>>(
                  future: ProductoService.obtenerImagenes(id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error al cargar las imágenes.'));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No hay imágenes disponibles.'));
                    }

                    final imagenes = snapshot.data!;
                    return Container(
                      height: 250,
                      child: PageView.builder(
                        itemCount: imagenes.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            imagenes[index],
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${producto['costo']}',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      SizedBox(height: 8),
                      Text(
                        producto['titulo'],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey, size: 20),
                          SizedBox(width: 4),
                          Text(producto['ubicacion'], style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        producto['descripcion'],
                        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Text(producto['vendedor'][0]), // Inicial del vendedor
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              producto['vendedor'],
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(producto['correo'], style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                            SizedBox(height: 4),
                            Text(producto['telefono'], style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                idUsuario != null ? FutureBuilder<bool>(
                  future: ProductoService.puedeEditarEliminar(id, idUsuario),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError || snapshot.data == false) {
                      return SizedBox(); // No mostrar nada si no tiene permisos
                    }

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Lógica para editar
                            },
                            child: Text('Editar'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Lógica para eliminar
                            },
                            child: Text('Eliminar'),
                          ),
                        ],
                      ),
                    );
                  },
                ) : SizedBox(), // No mostrar botones de edición/eliminación si idUsuario es nulo
              ],
            ),
          );
        },
      ),
    );
  }
}
