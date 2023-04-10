import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CV App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Widget buildSkillBar(String skill, double level) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            skill,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          LinearProgressIndicator(
            value: level,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/img1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 16.0),
                          Center(
                            child: CircleAvatar(
                              radius: 75.0,
                              backgroundImage:
                                  AssetImage('assets/images/img.jpg'),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Center(
                            child: Text(
                              'Ahsan Saeed',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'PERSONAL INFORMATION',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Divider(),
                          SizedBox(height: 8.0),
                          Card(
                            child: ListTile(
                              title: Text('Email'),
                              subtitle: Text('ahsansaeed157wb@gmail.com'),
                              leading: Icon(Icons.email),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Card(
                            child: ListTile(
                              title: Text('Phone'),
                              subtitle: Text('+923062447627'),
                              leading: Icon(Icons.phone),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Card(
                            child: ListTile(
                              title: Text('Address'),
                              subtitle: Text('Pakpattan Green Town'),
                              leading: Icon(Icons.location_on),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'EDUCATION',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Divider(),
                          SizedBox(height: 8.0),
                          Card(
                            child: ListTile(
                              title: Text(
                                  'Bachelor of Science in Computer Science'),
                              subtitle: Text(
                                  'Comsats University Islamabad Vehari Campus'),
                              trailing: Text('Graduated in May 2023'),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'WORK EXPERIENCE',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Divider(),
                          SizedBox(height: 8.0),
                          Card(
                              child: Column(children: <Widget>[
                            ListTile(
                              title: Text('Software Engineer'),
                              subtitle: Text('NETSOL Technologies Inc Company'),
                              trailing: Text('June 2022 - Internship'),
                            ),
                          ])),
                          SizedBox(height: 16.0),
                          Text(
                            'SKILLS',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Divider(),
                          SizedBox(height: 8.0),
                          buildSkillBar('Flutter', 0.9),
                          SizedBox(height: 8.0),
                          buildSkillBar('C-Sharp', 0.8),
                          SizedBox(height: 8),
                          SizedBox(height: 16.0),
                          Text(
                            'Hobbies',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Divider(),
                          SizedBox(height: 8.0),
                          Card(
                            child: Row(
                              children: [
                                Icon(Icons.directions_car),
                                Text('Drive'),
                                SizedBox(
                                  width: 50,
                                ),
                                Icon(Icons.shopping_cart),
                                Text('Shopping'),
                                SizedBox(
                                  width: 50,
                                ),
                                Icon(Icons.book),
                                Text('Reading Books'),
                                SizedBox(
                                  width: 50,
                                ),
                              ],
                            ),
                          ),
                        ])))));
  }
}
