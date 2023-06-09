import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examen/screens/home/home.dart';
import 'package:examen/screens/home/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  static String tag = 'register-page';
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _passwordlController = TextEditingController();
  final _confirmPasswordlController = TextEditingController();
  bool _showError = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _passwordlController.dispose();
    _confirmPasswordlController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future signUp() async {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _passwordlController.text.isEmpty ||
        _confirmPasswordlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Todos los campos son obligatorios')),
      );
      return;
    }

    if (!(num.tryParse(_ageController.text) != null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('La edad tiene que ser un número!')),
      );
      return;
    }

    final isValid = isValidEmail(_emailController.text);

    if (!isValid) {
      print('email not valid');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ingrese un correo electrónico válido'),
        ),
      );
    }

    // authenticate user
    if (passwordConfirmed() && isValid) {
      try {
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordlController.text.trim());
        print('User signed in: $userCredential');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Te has registrado con éxito!')),
        );

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                HomePage(userCredential: userCredential.user!.email)));

        // add user details
        addUserDetails(
          _firstNameController.text.trim(),
          _lastNameController.text.trim(),
          _emailController.text.trim(),
          int.parse(_ageController.text.trim()),
        );
      } on FirebaseAuthException catch (e) {
        print('Algo: $e');
        String? mensajeDeError = e.message;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$mensajeDeError')),
        );
      }
    }
  }

  Future addUserDetails(
      String firstName, String lastName, String email, int age) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'age': age,
    });
  }

  bool passwordConfirmed() {
    if (_passwordlController.text.trim() ==
        _confirmPasswordlController.text.trim()) {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return false;
    }
  }

  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 108.0,
        child: Image.asset('assets/icons/forkgit.png'),
      ),
    );

    final firstName = TextField(
      autofocus: false,
      controller: _firstNameController,
      decoration: InputDecoration(
        hintText: 'John',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final lastName = TextField(
      autofocus: false,
      controller: _lastNameController,
      decoration: InputDecoration(
        hintText: 'Manzano',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final age = TextField(
      autofocus: false,
      controller: _ageController,
      decoration: InputDecoration(
        hintText: 'Age',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final email = TextField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextField(
      autofocus: false,
      controller: _passwordlController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final confirmPassword = TextField(
      controller: _confirmPasswordlController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Confirm password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 39, 126, 126),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
        onPressed: () {
          signUp();
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Text('Register', style: TextStyle(color: Colors.white)),
      ),
    );

    final signInLabel = TextButton(
      child: Text(
        'Login',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 24.0),
            firstName,
            SizedBox(height: 8.0),
            lastName,
            SizedBox(height: 8.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 8.0),
            confirmPassword,
            SizedBox(height: 8.0),
            age,
            SizedBox(height: 24.0),
            loginButton,
            signInLabel,
          ],
        ),
      ),
    );
  }
}
