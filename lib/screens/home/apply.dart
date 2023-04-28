import 'dart:io';
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
  Future<void> uploadFile(PlatformFile file) async {
    try {
      // Genera una referencia al archivo en Firebase Storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = _storage.ref('archivos/$fileName');

      // Sube el archivo a Firebase Storage
      await storageRef.putData(file.bytes!);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information - ${widget.vacancy["title"]}'),
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
              SizedBox(height: 16.0),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
// Abre el explorador de archivos para seleccionar un documento
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                  if (result != null) {
                    PlatformFile file = result.files.single;
                    await uploadFile(file);
                  }
                },
                child: Text('Seleccionar archivo'),
              ),
              ElevatedButton(
                onPressed: _saveData,
                child: Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
