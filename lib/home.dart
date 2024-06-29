import 'package:calculator_app/global_colors.dart';
import 'package:flutter/material.dart';

 class home extends StatelessWidget{
   const home({Key? key}) : super(key : key);

   @override
   Widget build(BuildContext context){
     return Scaffold(
       backgroundColor: GlobalColors.mainColor ,
       body: Center(
         child: Text(
           ''
         )
       )
     );
   }
 }