import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_live_together/screens/login/login.dart';
import 'package:proyecto_live_together/screens/mi_perfil/mi_perfil.dart';
import 'package:proyecto_live_together/screens/productScreen/productScreen.dart';
import 'package:proyecto_live_together/screens/registerForRent/registerForRent.dart';
import 'package:proyecto_live_together/service/publicacion_service.dart';
import 'package:proyecto_live_together/utils/session.dart'; 


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedEstado;
  String? selectedLocalidad;
  String? selectedCategoria;
  final TextEditingController costoController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  late Future<List<Map<String, dynamic>>> publicacionesFuture;
  int? userId = Session().userId;

  @override
  void initState() {
    
    super.initState();
    publicacionesFuture =
        _fetchPublicaciones(); // Cargar publicaciones al iniciar
  }

  Future<List<Map<String, dynamic>>> _fetchPublicaciones() {
    return PublicacionService.listarPublicaciones();
  }

  // M�todo para aplicar filtros
  Future<void> aplicarFiltros() async {
    try {
      double? costoMaximo = double.tryParse(costoController.text);
      String? ubicacionSeleccionada = selectedLocalidad;

      List<Map<String, dynamic>> publicacionesFiltradas =
          await PublicacionService.filtrarPublicaciones(
        costoMaximo: costoMaximo,
        ubicacion: ubicacionSeleccionada,
      );

      setState(() {
        publicacionesFuture = Future.value(publicacionesFiltradas);
      });
    } catch (e) {
      print("Error al aplicar filtros: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        toolbarHeight: 80,
        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.home, color: Colors.white),
                      onPressed: () {},
                    ),
                    Text('Inicio', style: TextStyle(color: Colors.white)),
                  ],
                ),
                
Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    IconButton(
      icon: FaIcon(
        userId != null
            ? FontAwesomeIcons.userCircle // Icono para "Mi perfil"
            : FontAwesomeIcons.user, // Icono para "Iniciar sesión"
        color: Colors.white,
      ),
      onPressed: () {
        if (userId != null) {
          // Si el usuario está autenticado, navegar a "Mi perfil"
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MiPerfil(idUsuario: userId,)), // Cambiar a la pantalla de perfil
          );
        } else {
          // Si no está autenticado, navegar a "Iniciar sesión"
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginScreen()), // Mantener la pantalla de login
          );
        }
      },
    ),
    Text(
      userId != null ? 'Mi Perfil' : 'Iniciar Sesión', // Texto dinámico
      style: TextStyle(color: Colors.white),
    ),
  ],
),


                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.comments,
                          color: Colors.white),
                      onPressed: () {
                        // Agrega la acci�n para navegar si es necesario
                      },
                    ),
                    Text('Chat', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.star, color: Colors.white),
                      onPressed: () {
                        // Agrega la acci�n para navegar si es necesario
                      },
                    ),
                    Text('Membres�a', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Filtros',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 20),
            // Filtros: Dropdowns y campo de texto
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Ubicacion'),
                    items: [
                      DropdownMenuItem(
                          value: 'En espera', child: Text('En espera')),
                      DropdownMenuItem(
                          value: 'Ciudad A', child: Text('Ciudad A')),
                      DropdownMenuItem(
                          value: 'Ciudad B', child: Text('Ciudad B')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedLocalidad = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: costoController,
                    decoration: InputDecoration(
                      labelText: 'Costo',
                      hintText: 'Ingrese el costo m�ximo',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: aplicarFiltros, // Llamar al m�todo de filtros
                  child: Text('Aplicar filtros'),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Publicaciones
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: publicacionesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error al cargar publicaciones'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: Text('No hay publicaciones disponibles'));
                  }

                  final publicaciones = snapshot.data!;

                  return ListView.builder(
                    itemCount:
                        publicaciones.length, // Cantidad de publicaciones
                    itemBuilder: (context, index) {
                      final publicacion =
                          publicaciones[index]; // Publicaci�n actual
                      final List<dynamic> imagenes =
                          publicacion['imagenes'] ?? []; // Lista de im�genes
                      final String imagenUrl = imagenes.isNotEmpty
                          ? imagenes.first // Usa la primera imagen si existe
                          : 'https://via.placeholder.com/150'; // Imagen predeterminada

                      return Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              imagenUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.image_not_supported,
                                    size: 60, color: Colors.grey);
                              },
                            ),
                          ),
                          title: Text(publicacion['titulo'] ?? 'Sin t�tulo'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(publicacion['descripcion'] ??
                                  'Sin descripci�n'),
                              SizedBox(height: 4),
                              Text('Ubicaci�n: ${publicacion['ubicacion']}'),
                            ],
                          ),
                          trailing: Text('\$${publicacion['costo'] ?? '0'}'),
                          onTap: () {
                            final id = int.tryParse(
                                publicacion['idPublicacion'].toString());
                            if (id != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductScreen(id: id, idUsuario: userId ?? null),
                                ),
                              );
                            } else {
                              print("Error: El id no es v�lido");
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: userId != null
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PropertyRegistrationPage(idUsuario: userId,)),
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blueAccent,
            )
          : null,
    );
  }
}
