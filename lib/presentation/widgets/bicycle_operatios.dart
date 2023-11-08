import 'package:flutter/material.dart';
import '../../domain/entities/bicycles.dart';
import '../../shared/services/bicycle_service.dart';
import '../../shared/services/key_value_storage_service_impl.dart';
import 'package:http/http.dart' as http;


class BicycleOperation extends StatefulWidget {
  @override
  _BicycleOperationsState createState() => _BicycleOperationsState();
}

class _BicycleOperationsState extends State<BicycleOperation> {
  late final BicycleService bicycleService; // Instancia de BicycleService
  List<Bicycle> bicycles = [];


  int counter = 0;
  bool showFields = false;
  int? editingIndex;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _sizeController = TextEditingController();
  final _modelController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Crear la instancia de BicycleService aquí dentro de initState
    bicycleService = BicycleService(
      httpClient: http.Client(),
      keyValueStorage: KeyValueStorageImpl(), // Asegúrate de que esta clase esté definida y la ruta de importación sea correcta
    );
    // Luego, puedes llamar a métodos de BicycleService como getAllBicycles
    _loadBicycles();
  }

  void _loadBicycles() {
    bicycleService.getAllBicycles().then((fetchedItems) {
      setState(() {
        bicycles = fetchedItems;
      });
    }).catchError((error) {
      _showSnackBar('Error al obtener bicicletas: $error');
    });
  }



  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _sizeController.dispose();
    _modelController.dispose();
    _imageUrlController.dispose();
    bicycleService.httpClient.close(); // Cerrar el cliente HTTP
    super.dispose();
  }



  bool _validarCampos() {
    List<TextEditingController> controllers = [
      _nameController,
      _descriptionController,
      _priceController,
      _sizeController,
      _modelController,
      _imageUrlController
    ];

    bool areFieldsEmpty =
    controllers.any((controller) => controller.text.isEmpty);
    bool isUrlValid =
        Uri.tryParse(_imageUrlController.text)?.hasScheme ?? false;

    if (areFieldsEmpty || !isUrlValid) {
      _showSnackBar('Todos los campos son obligatorios y deben ser válidos.');
      return false;
    }
    return true;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red));
  }



  void _addBicycle() async {
    if (_validarCampos()) {
      // Para nuevas bicicletas, no debes proporcionar un ID,
      // el servidor debería encargarse de generar uno.
      Bicycle newBicycle = _constructBicycleFromControllers();
      try {
        Bicycle createdBicycle = await bicycleService.addBicycle(newBicycle);
        setState(() {
          bicycles.add(createdBicycle);
          counter++; // Actualizar el contador si estás usando IDs locales.
          showFields = false;
        });
        _clearControllers();
      } catch (e) {
        _showSnackBar('Error al agregar bicicleta: $e');
      }
    }
  }

  Bicycle _constructBicycleFromControllers([int? id]) {
    // El ID es opcional y solo se debe usar cuando estás actualizando una bicicleta
    return Bicycle(
      id: id, // Pasa el ID si está disponible
      bicycleName: _nameController.text,
      bicycleDescription: _descriptionController.text,
      bicyclePrice: double.tryParse(_priceController.text) ?? 0,
      bicycleSize: _sizeController.text,
      bicycleModel: _modelController.text,
      imageData: _imageUrlController.text,
    );
  }



  void _editBicycle(int index) {
    setState(() {
      editingIndex = index;
      showFields = true;
    });

    _nameController.text = bicycles[index].bicycleName;
    _descriptionController.text = bicycles[index].bicycleDescription;
    _priceController.text = bicycles[index].bicyclePrice.toString();
    _sizeController.text = bicycles[index].bicycleSize;
    _modelController.text = bicycles[index].bicycleModel;
    _imageUrlController.text = bicycles[index].imageData;
  }

  void _updateBicycle() async {
    if (_validarCampos()) {
      if (editingIndex != null) {
        // Cuando actualizamos, sí usamos el ID de la bicicleta existente.
        Bicycle updatedBicycle = _constructBicycleFromControllers(bicycles[editingIndex!].id);
        try {
          Bicycle serverUpdatedBicycle = await bicycleService.updateBicycle(updatedBicycle);
          setState(() {
            bicycles[editingIndex!] = serverUpdatedBicycle;
            editingIndex = null;
            showFields = false;
          });
          _clearControllers();
        } catch (e) {
          _showSnackBar('Error al actualizar la bicicleta: $e');
        }
      }
    }
  }





  void _clearControllers() {
    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _sizeController.clear();
    _modelController.clear();
    _imageUrlController.clear();
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmación",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        content: Text("¿Estás seguro de que deseas eliminar esta bicicleta?"),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              // Verifica si el ID no es nulo antes de intentar eliminar la bicicleta
              final int? itemId = bicycles[index].id;
              if (itemId == null) {
                // Manejo de error si el ID es nulo
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('No se puede eliminar la bicicleta: ID no disponible.'),
                    backgroundColor: Colors.red,
                  ),
                );
                Navigator.of(context).pop(); // Cerrar el diálogo
                return;
              }

              try {
                await bicycleService.deleteBicycle(itemId);
                setState(() {
                  bicycles.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Bicicleta eliminada con éxito.'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error al eliminar la bicicleta: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              Navigator.of(context).pop(); // Cerrar el diálogo
            },
            child: Text("Sí"),
            style: TextButton.styleFrom(primary: Colors.red),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo
            },
            child: Text("No"),
          ),
        ],
      ),
    );
  }


  void _showDetails(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(bicycles[index].bicycleName),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _customText('Descripción: ', bicycles[index].bicycleDescription),
            _customText('Precio: ', bicycles[index].bicyclePrice.toString()),
            _customText('Tamaño: ', bicycles[index].bicycleSize),
            _customText('Modelo: ', bicycles[index].bicycleModel),
            SizedBox(height: 12.0),
            if (bicycles[index].imageData.isNotEmpty)
              Image.network(
                bicycles[index].imageData,
                height: 200,
              ),
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



  @override
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
        actions: [
          // Esto agrega elementos al lado derecho del AppBar
          Icon(Icons.person),
        ],
      ),
      body: Column(
        children: [
          if (showFields) _buildBicycleForm(),
          if (!showFields) _buildAddNewBicycleButton(),
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
            _buildTextField(
                controller: _nameController,
                labelText: 'Introduce el nombre de la bicicleta'),
            SizedBox(height: 12.0),
            _buildTextField(
                controller: _descriptionController,
                labelText: 'Introduce una descripción'),
            SizedBox(height: 12.0),
            _buildTextField(
                controller: _priceController,
                labelText: 'Introduce un precio'),
            SizedBox(height: 12.0),
            _buildTextField(
                controller: _sizeController, labelText: 'Introduce un tamaño'),
            SizedBox(height: 12.0),
            _buildTextField(
                controller: _modelController, labelText: 'Introduce un modelo'),
            SizedBox(height: 12.0),
            _buildTextField(
                controller: _imageUrlController,
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
          // Obtener la URL de la imagen, si es 'null' como texto o realmente nula, usar una imagen de reserva.
          String? imageUrl = bicycles[index].imageData;
          bool isValidUrl = imageUrl != null && imageUrl.isNotEmpty && imageUrl != "null";

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
            child: Card(
              elevation: 10,
              child: ListTile(
                title: Text(bicycles[index].bicycleName),
                subtitle: Text(bicycles[index].bicycleDescription),
                leading: isValidUrl
                    ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    // Si hay un error al cargar la imagen, se muestra una imagen de reserva.
                    return Image.asset('images/default_image.png', fit: BoxFit.cover);
                  },
                )
                    : Image.asset('images/default_image.png', fit: BoxFit.cover), // Imagen de reserva si la URL es nula o 'null'.
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