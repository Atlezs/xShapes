import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fourshapes/main.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static const String _title = 'Sample App';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: null,
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 100, 10, 30),
                child: Image.asset('assets/logo.png')),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
                height: 90,
                padding: const EdgeInsets.fromLTRB(10, 45, 10, 0),
                child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      Future<loginInfo> submitData(String devkey,
                          String username, String password) async {
                        final response = await http.post(
                          Uri.parse(
                              'https://xshapetest.azurewebsites.net/login'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, String>{
                            'devKey': devkey,
                            'userName': username,
                            'password': password,
                          }),
                        );

                        if (response.statusCode == 200) {
                          var jsonData =
                              getInfo.fromJson(jsonDecode(response.body));

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => MyApp2(
                                      userID: jsonData.userID,
                                      name: jsonData.name,
                                      apiKey: jsonData.apiKey,
                                      lastLogin: jsonData.lastLogin,
                                      role: jsonData.role)));
                          return json.decode(response.body);
                        } else {
                          throw Exception('Error');
                        }
                      }

                      submitData("1a0b530fb9152cacfe6bd2d831d63f23",
                          nameController.text, passwordController.text);
                    })),
          ],
        ));
  }
}

class loginInfo {
  final String devkey;
  final String username;
  final String password;

  loginInfo(this.devkey, this.username, this.password);
}

class getInfo {
  final int userID;
  final String name;
  final String apiKey;
  final String lastLogin;
  final String role;

  getInfo(
      {required this.userID,
      required this.name,
      required this.apiKey,
      required this.lastLogin,
      required this.role});

  factory getInfo.fromJson(Map<String, dynamic> json) {
    return getInfo(
        userID: json['userID'],
        name: json['name'],
        apiKey: json['apiKey'],
        lastLogin: json['lastLogin'],
        role: json['role']);
  }
}
