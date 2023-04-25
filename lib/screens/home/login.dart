import 'package:examen/screens/home/home.dart';
import 'package:examen/screens/home/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordlController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    void _signIn() async {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordlController.text,
        );
        // print('User signed in: ${userCredential.user!.uid}');
        print('User signed in: ${userCredential.user}');
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                HomePage(userCredential: userCredential.user!.email)));
      } on FirebaseAuthException catch (e) {
        print('Failed to sign in user: $e');
      }
    }

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 108.0,
        child: Image.asset('assets/icons/forkgit.png'),
      ),
    );

    final email = TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextField(
      controller: _passwordlController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(24),
        // ),

        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 39, 126, 126),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20)),

        onPressed: () {
          _signIn();
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => HomePage()));
        },

        child: Text('LogIn', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = TextButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    final signInLabel = TextButton(
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => RegisterPage()));
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
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            SizedBox(height: 24.0),
            forgotLabel,
            SizedBox(height: 24.0),
            signInLabel
          ],
        ),
      ),
    );
  }
}
