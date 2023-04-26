import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
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
  File? _selectedFile;

  void _openFileExplorer() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _saveData() async {
    // Validate the form before saving the data
    if (_formKey.currentState!.validate()) {
      try {
        // Reference to the Firebase database
        final databaseRef =
            FirebaseDatabase.instance.ref('documentos').push().set({
          "name": _name,
          "email": _email,
          "phone": _phone,
          "address": _address,
          "vacantePostulado":
              widget.vacancy, // Agrega la información de la vacante aquí
          "cv_url": _selectedFile?.path
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
