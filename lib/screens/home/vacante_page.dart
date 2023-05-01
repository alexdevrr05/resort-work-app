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

   String company ="";
   String title  ="";
   String location ="";
   String logoUrl ="";
   List<String> _requisitos = ['0','1','2','3'];
   String time = "";

 Future<void> _saveData() async {
    // Validate the form before saving the data
    if (_formKey.currentState!.validate()) {
      try {
            // Validate the requisitos before saving the data
      if (!validarRequisitos(_requisitos)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('El arreglo de requisitos debe tener al menos 4 elementos'),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }
        // Reference to the Firebase database
        final databaseRef =
            FirebaseDatabase.instance.ref('jobs').push().set({
                
        "company": company,
        "title": title,
        "location": location,
        "logoUrl" : "https://cdn-icons-png.flaticon.com/512/9167/9167056.png",
        "req": _requisitos,
        "time": time,
        "isMark": false,
      });
        
       print("Data saved successfully!");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Vacante publicada con éxito'),
            duration: Duration(seconds: 3),
          ),
        );
        _formKey.currentState!.reset();
      } catch (e) {
        print("Failed to save data: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al publicar la vacante. Intente nuevamente.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
  bool validarRequisitos(List<String> requisitos) {
  if (requisitos.length < 4) {
    return false;
  }
  return true;
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
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese la compañia';
                  }
                  return null;
                },
                onChanged: (value) {
                  company = value;
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
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el puesto';
                  }
                  return null;
                },
                onChanged: (value) {
                    title = value ;
                  
                },
              ),
               SizedBox(height: 25.0),
              for (int i = 0; i < 4; i++) 
              TextFormField(
                decoration: InputDecoration(//requisito 0
                  labelText: 'Requisitos ',
                  prefixIcon: Icon(FontAwesomeIcons.file,
                  color: Color.fromARGB(255, 108, 12, 12),
                  ),
                ),
                validator: (String ?value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese los requisitos';
                  }
                  return null;
                },
              onChanged: (value) {
               if (_requisitos.length < 4) {
                _requisitos.add(value);
                } else {
                  _requisitos[i] = value;
      }
                },
              ),
               

             

             
             
              SizedBox(height: 25.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Ubicación',
                  prefixIcon: Icon(FontAwesomeIcons.locationPinLock,
                   color: Color.fromARGB(255, 126, 17, 20),
                  
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese la ubicación del trabajo';
                  }
                  return null;
                },
                onChanged: (value) {
                  location = value;
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
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el tiempo';
                  }
              return null;
            },
            onChanged:  (value) {
              time = value;
            },
          ),
          SizedBox(height: 20.0),

          ElevatedButton(
            onPressed: _saveData,
            
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