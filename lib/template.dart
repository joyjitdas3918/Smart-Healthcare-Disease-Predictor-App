import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class template extends StatefulWidget {  @override
  State<template> createState() => _templateState();
}

class _templateState extends State<template> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors:
                  [
                    Colors.black,
                    Colors.pink,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
            ),
          ),
        ],
      ),

    );
  }}
