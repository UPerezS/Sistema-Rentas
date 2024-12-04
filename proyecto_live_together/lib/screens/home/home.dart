// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:proyecto_live_together/screens/login/login.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String? selectedEstado;
//   String? selectedLocalidad;
//   String? selectedCategoria;
//   final TextEditingController costoController = TextEditingController();
//   final TextEditingController descripcionController = TextEditingController();

//   void navigateToAtrapa(BuildContext context) {

//   }

//   void onSubmit() {
//     print('Estado: $selectedEstado');
//     print('Localidad: $selectedLocalidad');
//     print('Categor�a: $selectedCategoria');
//     print('Costo: ${costoController.text}');
//     print('Descripci�n: ${descripcionController.text}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent,
//         toolbarHeight: 80,
//         actions: [
//           Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: FaIcon(FontAwesomeIcons.home, color: Colors.white),
//                       onPressed: () => navigateToAtrapa(context),
//                     ),
//                     Text('Inicio', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: FaIcon(FontAwesomeIcons.user, color: Colors.white),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   LoginScreen()), // Reemplaza con el nombre de tu pantalla de login
//                         );
//                       },
//                     ),
//                     Text('Iniciar Sesión',
//                         style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: FaIcon(FontAwesomeIcons.comments,
//                           color: Colors.white),
//                       onPressed: () => navigateToAtrapa(context),
//                     ),
//                     Text('Chat', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: FaIcon(FontAwesomeIcons.star, color: Colors.white),
//                       onPressed: () => navigateToAtrapa(context),
//                     ),
//                     Text('Membrec�a', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 20),
//             Text(
//               'Filtros',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blueAccent,
//                 letterSpacing: 1.5,
//               ),
//             ),
//             SizedBox(height: 20),
//             // Primera fila: Dropdowns
//             Row(
//               children: [
//                 Expanded(
//                   child: DropdownButtonFormField<String>(
//                     decoration: InputDecoration(labelText: 'Estado'),
//                     items: [
//                       DropdownMenuItem(
//                           value: 'En espera', child: Text('En espera')),
//                       DropdownMenuItem(value: 'Activo', child: Text('Activo')),
//                       DropdownMenuItem(
//                           value: 'Finalizado', child: Text('Finalizado')),
//                     ],
//                     onChanged: (value) {
//                       setState(() {
//                         selectedEstado = value;
//                       });
//                     },
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: DropdownButtonFormField<String>(
//                     decoration: InputDecoration(labelText: 'Localidad'),
//                     items: [
//                       DropdownMenuItem(
//                           value: 'En espera', child: Text('En espera')),
//                       DropdownMenuItem(
//                           value: 'Ciudad A', child: Text('Ciudad A')),
//                       DropdownMenuItem(
//                           value: 'Ciudad B', child: Text('Ciudad B')),
//                     ],
//                     onChanged: (value) {
//                       setState(() {
//                         selectedLocalidad = value;
//                       });
//                     },
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: DropdownButtonFormField<String>(
//                     decoration: InputDecoration(labelText: 'Categor�a'),
//                     items: [
//                       DropdownMenuItem(
//                           value: 'En espera', child: Text('En espera')),
//                       DropdownMenuItem(
//                           value: 'Opci�n 1', child: Text('Opci�n 1')),
//                       DropdownMenuItem(
//                           value: 'Opci�n 2', child: Text('Opci�n 2')),
//                     ],
//                     onChanged: (value) {
//                       setState(() {
//                         selectedCategoria = value;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             // Segunda fila: Campos de texto y bot�n
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: costoController,
//                     decoration: InputDecoration(
//                       labelText: 'Costo',
//                       hintText: 'Ingrese el costo',
//                     ),
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: TextField(
//                     controller: descripcionController,
//                     decoration: InputDecoration(
//                       labelText: 'Descripci�n',
//                       hintText: 'Ingrese una descripci�n',
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: onSubmit,
//                   child: Text('Enviar'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// }

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_live_together/screens/login/login.dart';
import 'package:proyecto_live_together/screens/productScreen/productScreen.dart';
import 'package:proyecto_live_together/service/publicacion_service.dart';

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

  @override
  void initState() {
    super.initState();
    publicacionesFuture =
        _fetchPublicaciones(); // Cargar publicaciones al iniciar
  }

  Future<List<Map<String, dynamic>>> _fetchPublicaciones() {
    // Simulación de la carga de publicaciones
    return PublicacionService.listarPublicaciones();
  }

  void onSubmit() {
    print('Localidad: $selectedLocalidad');
    print('Costo: ${costoController.text}');
    // Aquí puedes agregar lógica para filtrar las publicaciones con los datos de los filtros
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
                      onPressed: () {
                        // Agrega la acción para navegar si es necesario
                      },
                    ),
                    Text('Inicio', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.user, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                    ),
                    Text('Iniciar Sesión',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.comments,
                          color: Colors.white),
                      onPressed: () {
                        // Agrega la acción para navegar si es necesario
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
                        // Agrega la acción para navegar si es necesario
                      },
                    ),
                    Text('Membresía', style: TextStyle(color: Colors.white)),
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
            // Filtros: Dropdowns
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Ubicación'),
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
                SizedBox(width: 16), // Ajustado el espacio entre los dropdowns
              ],
            ),
            SizedBox(height: 16),
            // Campo de texto y botón para costo
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: costoController,
                    decoration: InputDecoration(
                      labelText: 'Costo',
                      hintText: 'Ingrese el costo',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onSubmit,
                  child: Text('Enviar'),
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
                    itemCount: publicaciones
                        .length, // Cantidad de publicaciones consultadas
                    itemBuilder: (context, index) {
                      final publicacion =
                          publicaciones[index]; // Obtén la publicación actual
                      return Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          title: Text(publicacion['titulo'] ?? 'Sin título'),
                          subtitle: Text(
                              publicacion['descripcion'] ?? 'Sin descripción'),
                          trailing: Text('\$${publicacion['costo'] ?? '0'}'),
                          onTap: () {
                            final id = int.tryParse(
                                publicacion['idPublicacion'].toString());
                            if (id != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductScreen(id: id),
                                ),
                              );
                            } else {
                              print("Error: El id no es válido");
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
    );
  }
}
