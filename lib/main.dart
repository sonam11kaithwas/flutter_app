import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:email_validator/email_validator.dart';

import 'UserRegister.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyLoginClass(),
    );
  }
}




class MyLoginClass extends StatefulWidget {
  const MyLoginClass({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MyLoginClass> {
  TextEditingController nameController = TextEditingController()..text='eve.holt@reqres.in';
  TextEditingController passwordController = TextEditingController()..text='cityslicka';

  getDataFromServer(String email, String pass) async {
    final response = await http
    .post(Uri.parse('https://reqres.in/api/login'),body: {'email':email , 'password':pass});

    if (response.statusCode == 200) {
      debugPrint('movieTitle: "' +response.body);

    } else {
      throw Exception('Failed to load album');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter First App'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Login page',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',

                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: (){
                    //forgot password screen
                  },
                  textColor: Colors.blue,
                  child: Text('Forgot Password'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Login'),
                      onPressed: () {
                      String msgs="No error";
                        if (nameController.text == null || nameController.text.isEmpty) {
                          // validator :(val) =>(EmailValidator.validate(nameController.text));

                          msgs='Please enter valid name';
                        }else if (passwordController.text == null || passwordController.text.isEmpty) {
                          msgs='Please enter valid password';
                        } else {
                          print(nameController.text);
                          print(passwordController.text);
                          getDataFromServer(nameController.text , passwordController.text);
                          return;
                        }
                      Fluttertoast.showToast(
                          msg: msgs,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      },
                    )),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('Does not have account?'),
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'Sign in',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            //signup screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UserRegister()),
                            );
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )));
  }
}
