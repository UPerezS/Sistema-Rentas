import 'package:flutter/material.dart';
import 'package:proyecto_live_together/screens/productScreen/productScreen.dart';
import '../../service/perfil_service.dart';
import '../../service/productScreen_service.dart';

class MiPerfil extends StatelessWidget {
  final int idUsuario;

  MiPerfil({int? idUsuario}) : idUsuario = idUsuario ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: PerfilService.obtenerDetallesUsuario(idUsuario),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error al cargar el perfil.'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('Usuario no encontrado.'));
          }

          final usuario = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Text(
                          usuario['nombre'][0],
                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        usuario['nombre'] + ' ' + usuario['apellidos'],
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(usuario['correo'], style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 8),
                      Text(usuario['telefono'], style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          // Mostrar el diálogo para editar perfil
                          final datosEditados = await showDialog<Map<String, String>>(
                            context: context,
                            builder: (context) => EditarPerfilDialog(
                              nombreActual: usuario['nombre'],
                              apellidosActual: usuario['apellidos'],
                              correoActual: usuario['correo'],
                              telefonoActual: usuario['telefono'],
                            ),
                          );

                          if (datosEditados != null) {
                            try {
                              await PerfilService.actualizarUsuario(
                                idUsuario: idUsuario,
                                nombre: datosEditados['nombre']!,
                                apellidos: datosEditados['apellidos']!,
                                correo: datosEditados['correo']!,
                                telefono: datosEditados['telefono']!,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Perfil actualizado correctamente.')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error al actualizar el perfil.')),
                              );
                            }
                          }
                        },
                        child: Text('Editar Perfil'),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () async {
                          // Confirmar desactivación del perfil
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Eliminar Perfil'),
                              content: Text('¿Estás seguro de que deseas eliminar tu perfil? Esta acción desactivará tu cuenta.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: Text('Eliminar'),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            try {
                              await PerfilService.eliminarUsuario(idUsuario);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Perfil desactivado correctamente.')),
                              );
                              Navigator.pop(context); // Volver a la pantalla anterior
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error al desactivar el perfil.')),
                              );
                            }
                          }
                        },
                        child: Text('Eliminar Perfil'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Mis Publicaciones',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: ProductoService.obtenerPublicacionesUsuario(idUsuario),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error al cargar las publicaciones.'));
                    }
                    final publicaciones = snapshot.data ?? [];
                    if (publicaciones.isEmpty) {
                      return Center(child: Text('No tienes publicaciones.'));
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: publicaciones.length,
                      itemBuilder: (context, index) {
                        final publicacion = publicaciones[index];
                        return ListTile(
                          title: Text(publicacion['titulo']),
                          subtitle: Text('\$${publicacion['costo']} - ${publicacion['ubicacion']}'),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            final id = int.tryParse(
                                publicacion['idPublicacion'].toString());
                            if (id != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductScreen(
                                    id: id,
                                    idUsuario: idUsuario,
                                  ),
                                ),
                              );
                            } else {
                              print("Error: El id no es válido");
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EditarPerfilDialog extends StatefulWidget {
  final String nombreActual;
  final String apellidosActual;
  final String correoActual;
  final String telefonoActual;

  EditarPerfilDialog({
    required this.nombreActual,
    required this.apellidosActual,
    required this.correoActual,
    required this.telefonoActual,
  });

  @override
  _EditarPerfilDialogState createState() => _EditarPerfilDialogState();
}

class _EditarPerfilDialogState extends State<EditarPerfilDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _apellidosController;
  late TextEditingController _correoController;
  late TextEditingController _telefonoController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.nombreActual);
    _apellidosController = TextEditingController(text: widget.apellidosActual);
    _correoController = TextEditingController(text: widget.correoActual);
    _telefonoController = TextEditingController(text: widget.telefonoActual);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidosController.dispose();
    _correoController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Perfil'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _apellidosController,
                decoration: InputDecoration(labelText: 'Apellidos'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _correoController,
                decoration: InputDecoration(labelText: 'Correo'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Ingresa un correo válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefonoController,
                decoration: InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  if (value.length != 10 || !RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Ingresa un número de 10 dígitos';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, {
                'nombre': _nombreController.text,
                'apellidos': _apellidosController.text,
                'correo': _correoController.text,
                'telefono': _telefonoController.text,
              });
            }
          },
          child: Text('Guardar'),
        ),
      ],
    );
  }
}
