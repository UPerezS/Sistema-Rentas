import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto
            Image.network(
              'https://via.placeholder.com/400x300', // Reemplazar con tu imagen
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Precio
                  Text(
                    '\$200',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Título del producto
                  Text(
                    'Mid-Century Modern Armchair',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Ubicación
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey, size: 20),
                      SizedBox(width: 4),
                      Text(
                        'San Francisco, CA (94115)',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Descripción
                  Text(
                    'Mid-century modern armchair in like new condition. Dark stained walnut wood with light blue wool upholstery. Local pickup only.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                  SizedBox(height: 16),
                  // Botones
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text('Make Offer', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text('Message Seller', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Mapa
            Container(
              height: 200,
              color: Colors.grey[200], // Simula el fondo del mapa
              child: Center(
                child: Icon(Icons.map, size: 50, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.save, color: Colors.grey),
                    label: Text('Save Item', style: TextStyle(color: Colors.grey)),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.share, color: Colors.grey),
                    label: Text('Share Item', style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
            Divider(),
            // Información del vendedor
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150', // Imagen del vendedor
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Whitney Trump',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '2 mutual friends including Chris Tanner and Dancy Li',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'Very Responsive to messages. Typically replies within an hour.',
                              style: TextStyle(fontSize: 12, color: Colors.green[800]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
