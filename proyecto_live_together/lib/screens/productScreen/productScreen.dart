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
        title: Text('Detalles del Producto',
            style: TextStyle(color: Colors.black)),
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
                      return Center(
                          child: Text('Error al cargar las imágenes.'));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text('No hay imágenes disponibles.'));
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
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      SizedBox(height: 8),
                      Text(
                        producto['titulo'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey, size: 20),
                          SizedBox(width: 4),
                          Text(producto['ubicacion'],
                              style: TextStyle(color: Colors.grey[600])),
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
                        child: Text(
                            producto['vendedor'][0]), // Inicial del vendedor
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              producto['vendedor'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(producto['correo'],
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[600])),
                            SizedBox(height: 4),
                            Text(producto['telefono'],
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                idUsuario != null
                    ? FutureBuilder<bool>(
                        future:
                            ProductoService.puedeEditarEliminar(id, idUsuario),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                                  onPressed: () async {
                                    // Lógica para editar
                                    final datosEditados =
                                        await showDialog<Map<String, String>>(
                                      context: context,
                                      builder: (context) => EditarDialog(
                                        tituloActual: producto['titulo'],
                                        descripcionActual:
                                            producto['descripcion'],
                                        costoActual:
                                            producto['costo'].toString(),
                                        ubicacionActual: producto['ubicacion'],
                                      ),
                                    );

                                    if (datosEditados != null) {
                                      try {
                                        await ProductoService.editarProducto(
                                          idPublicacion: id,
                                          titulo: datosEditados['titulo']!,
                                          descripcion:
                                              datosEditados['descripcion']!,
                                          costo: double.parse(
                                              datosEditados['costo']!),
                                          ubicacion:
                                              datosEditados['ubicacion']!,
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Producto actualizado correctamente.')),
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Error al actualizar el producto.')),
                                        );
                                      }
                                    }
                                  },
                                  child: Text('Editar'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    // Confirmar eliminación
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Eliminar Producto'),
                                        content: Text(
                                            '¿Estás seguro de que deseas eliminar este producto?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: Text('Cancelar'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: Text('Eliminar'),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (confirm == true) {
                                      try {
                                        await ProductoService.eliminarProducto(
                                            id);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Producto eliminado correctamente.')),
                                        );
                                        Navigator.pop(
                                            context); // Volver a la pantalla anterior
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Error al eliminar el producto.')),
                                        );
                                      }
                                    }
                                  },
                                  child: Text('Eliminar'),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : SizedBox(), // No mostrar botones de edición/eliminación si idUsuario es nulo
              ],
            ),
          );
        },
      ),
    );
  }
}

class EditarDialog extends StatelessWidget {
  final String tituloActual;
  final String descripcionActual;
  final String costoActual;
  final String ubicacionActual;

  EditarDialog({
    required this.tituloActual,
    required this.descripcionActual,
    required this.costoActual,
    required this.ubicacionActual,
  });

  @override
  Widget build(BuildContext context) {
    final tituloController = TextEditingController(text: tituloActual);
    final descripcionController =
        TextEditingController(text: descripcionActual);
    final costoController = TextEditingController(text: costoActual);
    final ubicacionController = TextEditingController(text: ubicacionActual);

    return AlertDialog(
      title: Text('Editar Producto'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: costoController,
              decoration: InputDecoration(labelText: 'Costo'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: ubicacionController,
              decoration: InputDecoration(labelText: 'Ubicación'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, {
              'titulo': tituloController.text,
              'descripcion': descripcionController.text,
              'costo': costoController.text,
              'ubicacion': ubicacionController.text,
            });
          },
          child: Text('Guardar'),
        ),
      ],
    );
  }
}
