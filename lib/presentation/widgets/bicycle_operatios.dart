import 'package:flutter/material.dart';
import '../../domain/entities/bicycles.dart';
import '../../shared/services/bicycle_service.dart';

class BicycleOperation extends StatefulWidget {
  @override
  _BicycleOperationsState createState() => _BicycleOperationsState();
}

class _BicycleOperationsState extends State<BicycleOperation> {
  final apiService = ApiService();
  List<Bicycle> bicycles = [];

  int counter = 0;
  bool showFields = false;
  int? editingIndex;

  final _nameController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _precioController = TextEditingController();
  final _sizeController = TextEditingController();
  final _modelController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiService.fetchItems().then((fetchedItems) {
      setState(() {
        bicycles = fetchedItems;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descripcionController.dispose();
    _precioController.dispose();
    _sizeController.dispose();
    _modelController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  bool _validarCampos() {
    List<TextEditingController> controllers = [
      _nameController,
      _descripcionController,
      _precioController,
      _sizeController,
      _modelController,
      _imageUrlController
    ];

    bool areFieldsEmpty = controllers.any((controller) =>
    controller.text.isEmpty);
    bool isUrlValid = Uri
        .tryParse(_imageUrlController.text)
        ?.hasScheme ?? false;

    if (areFieldsEmpty || !isUrlValid) {
      _showSnackBar('Todos los campos son obligatorios y deben ser válidos.');
      return false;
    }
    return true;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red)
    );
  }

  Bicycle _constructBicycleFromControllers(int id) {
    return Bicycle(
      id,
      _nameController.text,
      _descripcionController.text,
      double.parse(_precioController.text),
      _sizeController.text,
      _modelController.text,
      _imageUrlController.text,
    );
  }

  void _addBicycle() async {
    if (_validarCampos()) {
      Bicycle newBicycle = _constructBicycleFromControllers(counter);
      try {
        Bicycle createdBicycle = await ApiService().createItem(newBicycle);
        setState(() {
          bicycles.add(createdBicycle);
          counter++;
          showFields = false;
        });
        _clearControllers();
      } catch (e) {
        _showSnackBar('Error: $e');
      }
    }
  }

  void _editBicycle(int index) {
    setState(() {
      editingIndex = index;
      showFields = true;
    });

    _nameController.text = bicycles[index].bicycleName;
    _descripcionController.text = bicycles[index].bicycleDescription;
    _precioController.text = bicycles[index].bicyclePrice.toString();
    _sizeController.text = bicycles[index].bicycleSize;
    _modelController.text = bicycles[index].bicycleModel;
    _imageUrlController.text = bicycles[index].imageData;
  }

  void _updateBicycle() async {
    if (_validarCampos()) {
      if (editingIndex != null) {
        Bicycle updatedBicycle = _constructBicycleFromControllers(
            bicycles[editingIndex!].id);
        try {
          Bicycle serverUpdatedBicycle = await ApiService().updateBicycle(
              updatedBicycle.id, updatedBicycle);
          setState(() {
            bicycles[editingIndex!] = serverUpdatedBicycle;
            editingIndex = null;
            showFields = false;
          });
          _clearControllers();
        } catch (e) {
          _showSnackBar('Error al actualizar el ítem: $e');
        }
      }
    }
  }

  void _clearControllers() {
    _nameController.clear();
    _descripcionController.clear();
    _precioController.clear();
    _sizeController.clear();
    _modelController.clear();
    _imageUrlController.clear();
  }


  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            backgroundColor: Colors.transparent,
            // Hacer transparente el color de fondo de AlertDialog
            content: Card(
              color: Colors.white70, // Color de advertencia p
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Confirmación", style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Text("¿Estás seguro de que deseas eliminar este ítem?"),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            int itemId = bicycles[index].id;
                            try {
                              bool isDeleted = await ApiService().deleteItem(
                                  itemId);
                              if (isDeleted) {
                                setState(() {
                                  bicycles.removeAt(index);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                          'Ítem eliminado con éxito.'),
                                          backgroundColor: Colors.red)
                                  );
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(
                                        'Error al eliminar el ítem del servidor.'),
                                        backgroundColor: Colors.red)
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(
                                      'Error al eliminar el ítem: $e'),
                                      backgroundColor: Colors.red)
                              );
                            }
                            Navigator.pop(context);
                          },
                          child: Text("Sí", textAlign: TextAlign.center),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("No", textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }


  void _showDetails(int index) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text(bicycles[index].bicycleName),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _customText(
                    'Descripción: ', bicycles[index].bicycleDescription),
                _customText(
                    'Precio: ', bicycles[index].bicyclePrice.toString()),
                _customText('Tamaño: ', bicycles[index].bicycleSize),
                _customText('Modelo: ', bicycles[index].bicycleModel),
                SizedBox(height: 12.0),
                if (bicycles[index].imageData.isNotEmpty)
                  Image.network(bicycles[index].imageData, height: 200,),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cerrar"),
              ),
            ],
          ),
    );
  }

  Widget _customText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: value,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla anterior
          },
        ),
        title: Text('Julio Ramirez'),
        actions: [ // Esto agrega elementos al lado derecho del AppBar
          Icon(Icons.person),
        ],
      ),
      body: Column(
        children: [
          if (showFields)
            _buildBicycleForm(),
          if (!showFields)
            _buildAddNewBicycleButton(),
          _buildBicyclesList(),
        ],
      ),
    );
  }



  Widget _buildBicycleForm() {
    return Card(
      color: Colors.white, // Color añadido aquí
      elevation: 10,
      margin: EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildTextField(controller: _nameController,
                labelText: 'Introduce el nombre de la bicicleta'),
            SizedBox(height: 12.0),
            _buildTextField(controller: _descripcionController,
                labelText: 'Introduce una descripción'),
            SizedBox(height: 12.0),
            _buildTextField(controller: _precioController,
                labelText: 'Introduce un precio'),
            SizedBox(height: 12.0),
            _buildTextField(
                controller: _sizeController, labelText: 'Introduce un tamaño'),
            SizedBox(height: 12.0),
            _buildTextField(
                controller: _modelController, labelText: 'Introduce un modelo'),
            SizedBox(height: 12.0),
            _buildTextField(controller: _imageUrlController,
                labelText: 'Introduce una dirección de imagen'),
            SizedBox(height: 12.0),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }


  Widget _buildActionButtons() {
    return Row(
      children: [
        if (editingIndex == null)
          ElevatedButton(
            child: Text('Agregar'),
            onPressed: _addBicycle,
          )
        else
          ElevatedButton(
            child: Text('Actualizar'),
            onPressed: _updateBicycle,
            style: ElevatedButton.styleFrom(primary: Colors.green),
          ),
        SizedBox(width: 12.0),
        ElevatedButton(
          child: Text('Cancelar'),
          onPressed: _cancelEditOrAdd,
          style: ElevatedButton.styleFrom(primary: Colors.red),
        ),
      ],
    );
  }

  void _cancelEditOrAdd() {
    setState(() {
      showFields = false;
      editingIndex = null; // Restablece el editingIndex a null
      _clearControllers();
    });
  }

  Widget _buildAddNewBicycleButton() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        child: Text('Agregar Nueva Bicicleta'),
        onPressed: () {
          setState(() {
            showFields = true;
          });
        },
      ),
    );
  }

  Widget _buildBicyclesList() {
    return Expanded(
      child: ListView.builder(
        itemCount: bicycles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
            child: Card(
              elevation: 10,
              child: ListTile(
                title: Text(bicycles[index].bicycleName),
                subtitle: Text(bicycles[index].bicycleDescription),
                leading: bicycles[index].imageData.isNotEmpty
                    ? Image.network(bicycles[index].imageData)
                    : null,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _editBicycle(index),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _confirmDelete(index),
                    ),
                    IconButton(
                      icon: Icon(Icons.visibility, color: Colors.green),
                      onPressed: () => _showDetails(index),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller, required String labelText}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}
