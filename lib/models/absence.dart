import 'package:application_de_suivie_etudiant/colors.dart';
import 'package:flutter/material.dart';

class Absence extends StatelessWidget {
   Absence({super.key, required this.date, required this.heure_debut, required this.heure_fin});
   String date;
   String heure_debut;
   String heure_fin;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: softred,
            borderRadius: BorderRadius.circular(5)
          ),
          child: Icon(Icons.close, color: softwhite,),
        ),
        title: Text(this.date),
        subtitle: Text(this.heure_debut+' - '+this.heure_fin, style: TextStyle(fontStyle: FontStyle.italic),),
        onTap: () {},
      ),
    );
  }
}