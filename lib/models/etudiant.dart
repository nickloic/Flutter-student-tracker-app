import 'dart:convert';
import 'package:application_de_suivie_etudiant/screens/home.dart';
import 'package:http/http.dart' as http;

import 'package:application_de_suivie_etudiant/colors.dart';
import 'package:application_de_suivie_etudiant/screens/detailstudent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Etudiant extends StatefulWidget {
  Etudiant({super.key, required this.fullname, required this.id, required this.matriculeEtudiant});
  String fullname;
  final id ;
  bool ispresent = true;
  String matriculeEtudiant;
  

  @override
  State<Etudiant> createState() => _EtudiantState();
  
}

class _EtudiantState extends State<Etudiant> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 30,
        height: 30,
        child: Icon(Icons.person),
        decoration: BoxDecoration(
        color: softblue,
        borderRadius: BorderRadius.circular(20)
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.id.toString()+' - '+widget.fullname, style: TextStyle(fontWeight: FontWeight.bold),),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                color: softgreen,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    present(widget.matriculeEtudiant, '2024-05-10', Home.Code_Matiere);
                    },
                  color: softwhite,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                color: softred,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {absent(widget.matriculeEtudiant, '2024-05-10', Home.Code_Matiere);},
                  color: softwhite,
                ),
              ),
            ],
          )
        ],
      ),
      subtitle: widget.ispresent? Text('present(e)', style: TextStyle(color: Colors.green),): Text('absent(e)', style: TextStyle(color: Colors.red),),
      onTap: () {
        Navigator.push((context), 
        MaterialPageRoute(builder: (context) => DetailEtudiant(studentName: widget.fullname, ispresent: widget.ispresent, idEtudiant: widget.id,matriculeEtudiant: widget.matriculeEtudiant,))
        );
      },
);
}
 void absent(String matriculeEtudiant, String date, String Code_Matiere ) async{
    final url = Uri.parse("https://suivie-etudiant-api.vercel.app/addAbsence");
    final headers = {"Content-Type": "application/json"};
    final body = {"date": date, "matriculeEtudiant": matriculeEtudiant, "codeMatiere": Code_Matiere};
    // print(body);
    http.post(url, headers: headers, body: jsonEncode(body));
  setState(() {
    widget.ispresent = false;
  });
 }

//  void absent(String matriculeEtudiant, String date, String Code_Matiere ) async{
//     final url = Uri.parse("http://localhost:5080/addAbsence");
//     final headers = {"Content-Type": "application/json"};
//     final body = {"date": date, "matriculeEtudiant": matriculeEtudiant, "codeMatiere": Code_Matiere};
//     // print(body);
//     http.post(url, headers: headers, body: jsonEncode(body));
//   setState(() {
//     widget.ispresent = false;
//   });
//  }
 void present(String matriculeEtudiant, String date, String Code_Matiere) async{
  final url = Uri.parse("https://suivie-etudiant-api.vercel.app/delAbsence");
    final headers = {"Content-Type": "application/json"};
    final body = {"date": date, "matriculeEtudiant": matriculeEtudiant, "codeMatiere": Code_Matiere};
    // print(body);
    http.post(url, headers: headers, body: jsonEncode(body));
  setState(() {
    widget.ispresent = true;
  });
 }

//  void present(String matriculeEtudiant, String date, String Code_Matiere) async{
//   final url = Uri.parse("http://localhost:5080/delAbsence");
//     final headers = {"Content-Type": "application/json"};
//     final body = {"date": date, "matriculeEtudiant": matriculeEtudiant, "codeMatiere": Code_Matiere};
//     // print(body);
//     http.post(url, headers: headers, body: jsonEncode(body));
//   setState(() {
//     widget.ispresent = true;
//   });
//  }



}