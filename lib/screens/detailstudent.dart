import 'package:application_de_suivie_etudiant/colors.dart';
import 'package:application_de_suivie_etudiant/models/absence.dart';
// import 'package:application_de_suivie_etudiant/models/cercle.dart';
// import 'package:application_de_suivie_etudiant/models/testanimation.dart';
import 'package:application_de_suivie_etudiant/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailEtudiant extends StatefulWidget {
  DetailEtudiant(
      {super.key,
      required this.studentName,
      required this.ispresent,
      required this.idEtudiant,
      required this.matriculeEtudiant});
  String studentName;
  bool ispresent;
  int idEtudiant;
  String matriculeEtudiant;

  static List<Absence> abcencesList = [];

  @override
  State<DetailEtudiant> createState() => _DetailEtudiantState();
}

class _DetailEtudiantState extends State<DetailEtudiant> {
  final NoteController = TextEditingController();
  String contactEtudiant = '';
  String contactParent = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAbsences();
    getNoteCC();
    getContact();
  }

  Future <void> getContact() async{
    final url = Uri.parse('https://suivie-etudiant-api.vercel.app/getcontact/' + widget.matriculeEtudiant);
    var res = await http.get(url);
    dynamic data = jsonDecode(res.body);

    setState(() {
      contactEtudiant = data[0]['contact_etudiant'].toString();
      contactParent = data[0]['contact_parents'].toString();
    });
  }
  // Future <void> getContact() async{
  //   final url = Uri.parse('http://localhost:5080/getcontact/' + widget.matriculeEtudiant);
  //   var res = await http.get(url);
  //   dynamic data = jsonDecode(res.body);

  //   setState(() {
  //     contactEtudiant = data[0]['contact_etudiant'].toString();
  //     contactParent = data[0]['contact_parents'].toString();
  //   });
  // }

  Future<void> getAbsences() async {
    final url = Uri.parse('https://suivie-etudiant-api.vercel.app/AbsenceEtudiants/' +
        widget.matriculeEtudiant +
        '/' +
        Home.Code_Matiere);
    var res = await http.get(url);
    dynamic data = jsonDecode(res.body);

    setState(() {
      DetailEtudiant.abcencesList = [
        for (var i in data)
          Absence(
              date: i['date_sceance'],
              heure_debut: i['heure_debut'],
              heure_fin: i['heure_fin'])
      ];
    });
  }
  // Future<void> getAbsences() async {
  //   final url = Uri.parse('http://localhost:5080/AbsenceEtudiants/' +
  //       widget.matriculeEtudiant +
  //       '/' +
  //       Home.Code_Matiere);
  //   var res = await http.get(url);
  //   dynamic data = jsonDecode(res.body);

  //   setState(() {
  //     DetailEtudiant.abcencesList = [
  //       for (var i in data)
  //         Absence(
  //             date: i['date_sceance'],
  //             heure_debut: i['heure_debut'],
  //             heure_fin: i['heure_fin'])
  //     ];
  //   });
  // }

  Future<void> getNoteCC() async {
    final url = Uri.parse('https://suivie-etudiant-api.vercel.app/noteCC/' +
        widget.matriculeEtudiant +
        '/' +
        Home.Code_Matiere +
        '/');
    var res = await http.get(url);
    dynamic data = jsonDecode(res.body);
    // print(data[0][0]['Note_cc']);
    setState(() {
      NoteController.text = data[0][0]['Note_cc'].toString();
    });
  }
  // Future<void> getNoteCC() async {
  //   final url = Uri.parse('http://localhost:5080/noteCC/' +
  //       widget.matriculeEtudiant +
  //       '/' +
  //       Home.Code_Matiere +
  //       '/');
  //   var res = await http.get(url);
  //   dynamic data = jsonDecode(res.body);
  //   // print(data[0][0]['Note_cc']);
  //   setState(() {
  //     NoteController.text = data[0][0]['Note_cc'].toString();
  //   });
  // }

  Future<void> setNoteCC(double note) async {
    final url = Uri.parse('https://suivie-etudiant-api.vercel.app/noteCC/' +
        widget.matriculeEtudiant +
        '/' +
        Home.Code_Matiere +
        '/');
    final headers = {"Content-Type": "application/json"};
    final body = {'Note': note};
    http.post(url, headers: headers, body: jsonEncode(body));
  }
  // Future<void> setNoteCC(double note) async {
  //   final url = Uri.parse('http://localhost:5080/noteCC/' +
  //       widget.matriculeEtudiant +
  //       '/' +
  //       Home.Code_Matiere +
  //       '/');
  //   final headers = {"Content-Type": "application/json"};
  //   final body = {'Note': note};
  //   http.post(url, headers: headers, body: jsonEncode(body));
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(350),
          child: AppBar(
            toolbarHeight: 350,
            backgroundColor: this.widget.ispresent ? softgreen : softred,
            title: Container(
              height: 350,
              padding: EdgeInsets.symmetric(horizontal: 30),
              margin: EdgeInsets.only(top: 100),
              child: Column(children: [
                Icon(
                  Icons.person,
                  size: 200,
                ),
                Text(this.widget.studentName),
                Text(this.widget.matriculeEtudiant),
              ]),
            ),
            bottom: TabBar(
                unselectedLabelColor: softwhite,
                labelColor: softblue,
                tabs: [
                  Tab(
                    icon: Icon(Icons.event_busy),
                  ),
                  Tab(
                    icon: Icon(Icons.info_outline),
                  ),
                ]),
          ),
        ),
        // body: absencesView(),
        body: TabBarView(
          children: [
            absencesView(),
            infoView()
            // Center(child: Text('Contenu du profil')),
          ],
        ),
      ),
    );
  }

  Container infoView() {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Text(
            'Ratio d\'absences: ',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          //cercle

          Text(
            'Note de cc :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Container(
                width: 300,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 5),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Color(0xfff1f1f1),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: NoteController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.notes,
                        color: Colors.black,
                        size: 20,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 25,
                        minHeight: 20,
                        maxWidth: 30,
                        minWidth: 30,
                      ),
                      hintText: 'Note de cc',
                      border: InputBorder.none),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: 50,
                width: 50,
                child: IconButton(
                  onPressed: () {
                    try {
                      double.parse(NoteController.text);
                      if (double.parse(NoteController.text) <= 20 &&
                          double.parse(NoteController.text) >= 0) {
                        setNoteCC(double.parse(NoteController.text));
                      } else {
                        print('Saisissez un nombre valide...');
                      }
                    } catch (e) {
                      print('Saisissez un nombre valide...');
                    }
                  },
                  icon: Icon(Icons.edit),
                ),
                margin: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: softblue,
                  borderRadius: BorderRadius.circular(10),
                ),
              )
            ],
          ),
          Container(
            // height: 50,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
            color: softwhite,
            borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
            children: [
              Text(
            'Contact de l\'etudiant \n' + contactEtudiant,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
            ],
          ),
          ),
          Container(
            // height: 50,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
            color: softwhite,
            borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
            children: [
              Text(
            'Contact du parent \n' + contactParent,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
            ],
          ),
          )
        ],
      ),
    );
  }

  Container absencesView() {
    return Container(
      margin: EdgeInsets.all(5),
      child: ListView(
        children: [
          Column(
            children: [
              Text(
                'Absences: ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              if (DetailEtudiant.abcencesList.isEmpty)
                Center(child: Text('Aucune absence trouvée pour cette matière'))
              else
                for (var i in DetailEtudiant.abcencesList) i,
            ],
          )
        ],
      ),
    );
  }
}
