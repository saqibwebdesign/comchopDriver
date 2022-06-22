import 'package:comchopdriver/login_signup_screens/signup_screen.dart';
import 'package:comchopdriver/tabbar/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http_services/htt_services.dart';
import 'login_signup_screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SharedPreferences aa = await SharedPreferences.getInstance();
  final gettoken = aa.getString('new');
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => http_service()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        ),
        home: gettoken == null ? MyHomePage() : tab_bar_screen(),
      ),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 193, 128, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Container(child: Image.asset('images/Bike.png'))),
          SizedBox(
            height: 25,
          ),
          Center(
              child: Text(
            'Welcome to ',
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 30, color: Colors.white),
          )),
          Center(
              child: Text(
            'comchop Driver App',
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 30, color: Colors.white),
          )),
          SizedBox(
            height: 25,
          ),
          Center(
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 41,
                      width: 124,
                      child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          color: Color.fromRGBO(252, 186, 24, 1),
                          child: Text(
                            'Signin',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      login_screen()),
                            );
                          })),
                  SizedBox(
                    width: 40,
                  ),
                  Container(
                      height: 41,
                      width: 124,
                      child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          color: Color.fromRGBO(252, 186, 24, 1),
                          child: Text(
                            'Signup',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      signup_screen()),
                            );
                          })),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
