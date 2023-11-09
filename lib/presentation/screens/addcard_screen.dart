import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar tarjeta'),
      ),
      body: AddCardForm(),
    );
  }
}
class AddCardForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Número de tarjeta'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Fecha de vencimiento'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Código de seguridad'),
          ),
          ElevatedButton(
            onPressed: () {
              // Pendiente (lógica de guardar tarjeta)
              context.go('/profile');
            },
            child: Text('Guardar tarjeta'),
          ),
        ],
      ),
    );
  }
}
