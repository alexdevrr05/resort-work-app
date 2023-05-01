import 'dart:io';
import 'dart:convert';
import 'package:examen/constants/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ApplyScreen extends StatefulWidget {
  final Map<String, dynamic> vacancy;

  ApplyScreen({required this.vacancy});

  @override
  _ApplyScreenState createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phone = '';
  String _address = '';

  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<void> uploadFile(File file) async {
    try {
      print('File path: ${file.path}'); // Imprimir la ruta del archivo

      // Genera una referencia al archivo en Firebase Storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      print('File name: $fileName'); // Imprimir el nombre del archivo

      Reference storageRef = _storage.ref('archivos/$fileName');
      print(
          'Storage ref: $storageRef'); // Imprimir la referencia de almacenamiento

      // Sube el archivo a Firebase Storage
      await storageRef.putFile(file);

      print('Archivo subido exitosamente');
    } catch (e) {
      print('Error al subir el archivo: $e');
    }
  }

  Future<void> _saveData() async {
    // Validate the form before saving the data
    if (_formKey.currentState!.validate()) {
      try {
        // Reference to the Firebase database
        final databaseRef =
            FirebaseDatabase.instance.ref().child('documentos').push();
        await databaseRef.set({
          "name": _name,
          "email": _email,
          "phone": _phone,
          "address": _address,
          "vacantePostulado":
              widget.vacancy, // Agrega la información de la vacante aquí
        });

        print("Data saved successfully!");
      } catch (e) {
        print("Failed to save data: $e");
      }
    }
  }

  void _cancel() async {
    final ref = FirebaseDatabase.instance.ref().child('documentos');
    Query query = ref.orderByChild('email').equalTo(_email);
    query.once().then((event) {
      // Aquí puedes acceder a los datos que coinciden con la consulta
      final values = Map<String, dynamic>.from(
          event.snapshot.value! as Map<Object?, Object?>);
      values.forEach((key, value) {
        value = jsonDecode(jsonEncode(value));
        if (value['vacantePostulado']['company'] == widget.vacancy['company'] &&
            value['vacantePostulado']['title'] == widget.vacancy['title']) {
          ref.child(key).remove();
        }
      });
      print("Usuarios eliminados correctamente");
    }).catchError((error) {
      print("Error al eliminar los usuarios: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information - ${widget.vacancy["title"]}'),
        backgroundColor: Color.fromARGB(255, 39, 126, 126),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _phone = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _address = value;
                  });
                },
              ),
              SizedBox(height: 6.0),
              Row(children: [
                ElevatedButton(
                  onPressed: _saveData,
                  child: Text('Save'),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 39, 126, 126),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _cancel,
                  child: Text('Cancel vacancy'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                  ),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
