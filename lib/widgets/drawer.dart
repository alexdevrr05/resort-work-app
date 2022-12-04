import 'package:flutter/material.dart';

class Drawer1 extends StatelessWidget {
  const Drawer1({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('Alex.com'),
              accountEmail: Text('alex123@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    'https://res.cloudinary.com/deryiakda/image/upload/v1662679037/tutorials/Captura_de_Pantalla_2022-09-08_a_la_s_18.16.44_lq8mj9.png',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1557682260-96773eb01377?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1658&q=80'),
                fit: BoxFit.cover,
              ))),
          ListTile(
            leading: Icon(
              Icons.flight_land_outlined,
              color: Colors.black,
            ),
            title: Text('Airline'),
            onTap: () => print('Pressed airline'),
          ),
          ListTile(
            leading: Icon(
              Icons.access_alarm,
              color: Colors.black,
            ),
            title: Text('Favorites'),
            onTap: () => print('Pressed favorites'),
          ),
          ListTile(
            leading: Icon(
              Icons.facebook,
              color: Colors.black,
            ),
            title: Text('Facebook'),
            onTap: () => print('Pressed facebook'),
          ),
          ListTile(
            leading: Icon(
              Icons.insert_invitation,
              color: Colors.black,
            ),
            title: Text('Instagram'),
            onTap: () => print('Pressed favorites'),
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            title: Text('Exit'),
            onTap: () => print('Pressed favorites'),
          ),
        ],
      ),
    );
  }
}
