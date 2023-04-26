import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examen/screens/home/home.dart';


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

  CollectionReference vacantes =
      FirebaseFirestore.instance.collection('jobs');

  Future<void> addVacante() {
    return vacantes
        .add({
          'company': company,
          'title': title,
          'location': location,
          'req': _requisitos,
          'descripcion': _descripcion,
          'time': time
        })
        .then((value) => print('Vacante agregada exitosamente'))
        .catchError((error) => print('Error al agregar la vacante: $error'));
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
                  prefixIcon: Icon(FontAwesomeIcons.file
                  
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
                  color: Colors.blueGrey,
                  
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
            
            child: Text('Publicar vacante'), //el boton de publicar
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius : BorderRadius.circular(10.0)),
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