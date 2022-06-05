import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemModel {

  late final String name;
  final String value;
  bool accepting;

  ItemModel({required this.name,required this.value, this.accepting=false});
}