import 'package:flutter/material.dart';
import 'package:fourshapes/login.dart';
import 'package:fourshapes/video.dart';
import 'home_page.dart';

void main() => runApp(const Login());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final String data;

  const MyApp({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      // ignore: prefer_const_constructors
      home: MyApp2(userID: 1, name: "", apiKey: "", lastLogin: "", role: ""),
    );
  }
}

class MyApp2 extends StatefulWidget {
  final int userID;
  final String name;
  final String apiKey;
  final String lastLogin;
  final String role;
  const MyApp2(
      {Key? key,
      required this.userID,
      required this.name,
      required this.apiKey,
      required this.lastLogin,
      required this.role})
      : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}

@override
class _MyAppState extends State<MyApp2> {
  final double _borderRadius = 24;
  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> list1 = widget.lastLogin.split("T");
    List<String> list2 = list1[1].split(".");
    final screens = [
      HomePage(data: widget.apiKey),
      Video(),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Current Login User"),
                    content: Text(
                        "Name: ${widget.name}\nAccess Level: ${widget.role}\n\nLast Login Date: ${list1[0]}\nLast Login Time: ${list2[0]}"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Container(
                          color: Colors.black,
                          padding: const EdgeInsets.all(14),
                          child: const Text("okay",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.account_circle))
        ],
        elevation: 2,
        title: Container(
          width: 100,
          child: Image.asset('assets/logo.png'),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff00695c),
              Color(0xff4db6ac),
            ], tileMode: TileMode.clamp),
          ),
        ),
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.videocam,
              ),
              label: 'Video'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
