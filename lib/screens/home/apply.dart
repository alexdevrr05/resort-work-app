import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _userEmail;

  @override
  void initState() {
    super.initState();
    _getCurrentUserEmail();
  }

  Future<void> _getCurrentUserEmail() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _userEmail = user.email;
      });
    }
  }

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
        final databaseRef = FirebaseDatabase.instance.reference();

        // Create a new document in the "documentos" collection
        final documentosRef = databaseRef.child('documentos').push();

        await documentosRef.set({
          'name': _name,
          'email': _userEmail,
          'phone': _phone,
          'address': _address,
          'vacantePostulado': {
            'company': widget.vacancy['company'],
            'title': widget.vacancy['title'],
            'logoUrl': widget.vacancy['logoUrl'],
          },
        });

        // Add a new aspirante to the "postulaciones" collection
        final jobsRef = databaseRef
            .child('postulaciones')
            .child(widget.vacancy['company'])
            .push();

        await jobsRef.set({
          'logoUrl': widget.vacancy['logoUrl'],
          'aspirante_name': _name,
          'aspirante_email': _userEmail,
          'phone': _phone,
          'address': _address,
        });

        print('Data saved successfully!');
      } catch (e) {
        print('Failed to save data: $e');
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
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Email'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your email';
              //     }
              //     return null;
              //   },
              //   onChanged: (value) {
              //     setState(() {
              //       _email = value;
              //     });
              //   },
              // ),
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
                  onPressed: () async {
                    // Abre el explorador de archivos para seleccionar un documento
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
                    if (result != null && result.files.single.path != null) {
                      File file = File(result.files.single.path!);
                      await uploadFile(file);
                    } else {
                      print('Error al obtener la ruta del archivo');
                    }
                  },
                  child: const Text('Select File'),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 39, 126, 126),
                  ),
                ),
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
