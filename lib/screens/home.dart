import 'package:application_de_suivie_etudiant/colors.dart';
import 'package:application_de_suivie_etudiant/models/etudiant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home({super.key, required this.codeMatiere});
  String codeMatiere;
  static String Code_Matiere = '';

  static List<Etudiant> etudiantsList = [];
  int nbStudent = 0;

  @override
  State<Home> createState() => _HomeState();
}

List<Etudiant>foundstudent = [];
class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStudents();
    Home.Code_Matiere = widget.codeMatiere;
  }
 

  Future <void> getStudents() async {
    final url = Uri.parse("https://suivie-etudiant-api.vercel.app/students/"+widget.codeMatiere);
    var res = await http.get(url);
    dynamic data = jsonDecode(res.body);
    
  // Future <void> getStudents() async {
  //   final url = Uri.parse("http://localhost:5080/students/"+widget.codeMatiere);
  //   var res = await http.get(url);
  //   dynamic data = jsonDecode(res.body);

    setState(() {
     Home.etudiantsList = [
      for(var i in data)
      Etudiant(fullname: i['nomEtudiant'], id: ++widget.nbStudent, matriculeEtudiant: i['matriculeEtudiant'],),
    ];
    foundstudent = Home.etudiantsList;
      
    });

}

  bool typingsearch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: typingsearch ? searchbar() : defaltAppbar(),
        backgroundColor: Colors.blue,
      ),
      body: Container(
          margin: EdgeInsets.all(5  ),
          child: ListView(
            children: [
              Text(
                Home.Code_Matiere+' Liste des etudiants: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Column(
                children: [
                  for (Etudiant i in foundstudent) i,
                ],
              )
            ],
          )),
    );
  }

  void istypeserach() {
    setState(() {
      typingsearch = !typingsearch;
    });
  }


  Widget searchbar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                istypeserach();
                initialstatesearch();
              },
              icon: Icon(Icons.arrow_back)),
          Expanded(
            child: TextField(
              onChanged: (text) {searchStudent(text);},
              decoration: InputDecoration(
                  hintText: 'Tap search here...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                  fontSize: 16,
                  )),
            ),
          )
        ],
      ),
    );
  }

  void initialstatesearch(){
    setState(() {
      foundstudent = Home.etudiantsList;
    });
  }
  void searchStudent(String s){
    List<Etudiant> result = [];
    result = Home.etudiantsList.where((el) => el.fullname.toLowerCase().contains(s.toLowerCase())).toList();
    setState(() {
      foundstudent = result;
    });
  }

  AppBar defaltAppbar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Etudiants TI-PAM '),
          IconButton(
              onPressed: () {
                istypeserach();
              },
              icon: Icon(
                Icons.search,
                color: softwhite,
              ))
        ],
      ),
      backgroundColor: Colors.blue,
    );
  }
}
