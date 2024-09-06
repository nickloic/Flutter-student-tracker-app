import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import './home.dart';
import './signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Connexion'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                child: Image.asset('assets/images/profil2.jpg', width: 300, height: 300,),
                borderRadius: BorderRadius.circular(1500),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      width: 350,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: Color(0xfff1f1f1),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: loginController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 20,
                            ),
                            prefixIconConstraints: BoxConstraints(
                              maxHeight: 25,
                              minHeight: 20,
                              maxWidth: 30,
                              minWidth: 30,
                            ),
                            hintText: 'login',
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                      width: 350,
                      height: 50,
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Color(0xfff1f1f1),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: passController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black,
                              size: 20,
                            ),
                            prefixIconConstraints: BoxConstraints(
                              maxHeight: 25,
                              minHeight: 20,
                              maxWidth: 30,
                              minWidth: 30,
                            ),
                            hintText: 'password',
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 150),
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // pushinfo(loginController.text.toLowerCase(), passController.text);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Home(codeMatiere: loginController.text.toUpperCase(),)));
                        },
                        child: Text(
                          'connexion',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          elevation: 8,
                          padding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('vous n\'avez pas de compte ? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, 
                              MaterialPageRoute(builder: (context) => const Signup())
                              );
                            },
                            child: 
                            Text('Connectez vous  ', style: TextStyle(color: Colors.blue),),
                          )
                        ],
                      )
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  // void pushinfo(String nom, String pass) async {
  //   final url = Uri.parse("http://localhost:5080/adduser");
  //   final headers = {"Content-Type": "application/json"};
  //   final body = {"nom": nom, "pass": pass};
  //   print(body);
  //   var res = http.post(url, headers: headers, body: jsonEncode(body));
  // }
}
