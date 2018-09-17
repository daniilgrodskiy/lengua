import 'package:flutter/material.dart';

class Question {
  final int numberIndex;
  final String title;
  final String answer;
  final String o1;
  final String o2;
  final String o3;
  final String o4;
  final String directions;
  final String explanation;


  Question(this.numberIndex, this.title, this.answer, this.o1, this.o2, this.o3, this.o4, this.directions, this.explanation);

}