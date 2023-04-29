import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:examen/screens/home/home.dart';
import 'package:firebase_database/firebase_database.dart';


class PublicarVacanteForm extends StatefulWidget {
  @override
  _PublicarVacanteFormState createState() => _PublicarVacanteFormState();
}

class _PublicarVacanteFormState extends State<PublicarVacanteForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String company;
  late String title;
  late String location;
  late String _requisitos;
  late String _descripcion;
  late int time;

 Future<void> _saveData() async {
    // Validate the form before saving the data
    if (_formKey.currentState!.validate()) {
      try {
        // Reference to the Firebase database
        final databaseRef =
            FirebaseDatabase.instance.ref('jobs').push().set({
        "company": company,
        "title": title,
        "location": location,
        "req": _requisitos,
        "descripcion": _descripcion,
        "time": time,
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //el texto principal
               SizedBox(height: 20),
              Text("¿Deseas publicar una vacante?", textAlign: TextAlign.right,  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold ,),),
                
              Text("Resort Work te ayuda a buscar tus preferencias",
              textAlign: TextAlign.center,style: TextStyle(fontSize: 16),),
              SizedBox(height: 20),
            Text("Completa los siguientes campos",
              textAlign: TextAlign.center,style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 11, 49, 81), fontWeight: FontWeight.bold,),),
             SizedBox(height: 20),



            //Aquí empiezan los campos para el formulario y la validación
             
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Compañia',
                  prefixIcon: Icon(FontAwesomeIcons.userCircle,
                  color: Color.fromARGB(255, 185, 107, 4),
                  ),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese la modalidad del trabajo';
                  }
                  return null;
                },
                onSaved: (String ?value) {
                  company = value!;
                },
              ),
               SizedBox(height: 25.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Puesto',
                  prefixIcon: Icon(FontAwesomeIcons.briefcase,
                  color: Colors.black,
                  ),
                ),
                validator: (String ?value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese el puesto';
                  }
                  return null;
                },
                onSaved: (String ?value) {
                  setState(() {
                    title = value !;
                  });
                  
                },
              ),
              SizedBox(height: 25.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Requisitos',
                  prefixIcon: Icon(FontAwesomeIcons.fileAlt,
                  color: Color.fromARGB(255, 108, 12, 12),
                  ),
                ),
                validator: (String ?value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese los requisitos';
                  }
                  return null;
                },
                onSaved: (String ?value) {
                  _requisitos = value !;
                },
              ),
              SizedBox(height: 25.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Localizacion',
                  prefixIcon: Icon(FontAwesomeIcons.locationPinLock,
                   color: Color.fromARGB(255, 126, 17, 20),
                  
                  ),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese la localizacion del trabajo';
                  }
                  return null;
                },
                onSaved: (String ?value) {
                  location = value!;
                },
              ),
              
        
              SizedBox(height: 25.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Tiempo',
                  
                  prefixIcon: Icon(FontAwesomeIcons.clock,
                  color: Color.fromARGB(255, 28, 76, 99),
                  
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (String ?value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese el tiempo';
                  }
              return null;
            },
            onSaved: (String ?value) {
              time = int.parse(value!);
            },
          ),
          SizedBox(height: 20.0),

          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                
                


                //aqui muestra en la pantalla del telefono una alerta y boton de ok para cerrar
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Vacante Publicada'),
                      content: Text('¡La vacante ha sido publicada exitosamente!'),
                      actions: <Widget>[
                        ElevatedButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            
            child: Text('Publicar vacante',
            style: TextStyle(fontFamily: 'MontserratSubrayada'),
            ),
            
             //el boton de publicar
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius : BorderRadius.circular(15.0)),
              backgroundColor: Color.fromARGB(255, 12, 33, 50), // Color de fondo del botón
              textStyle:TextStyle(color: Colors.white30, fontWeight: FontWeight.bold) // Color del texto del botón
            ),

          ),
        ],
      ),
    ),
  ),
);
  }
}