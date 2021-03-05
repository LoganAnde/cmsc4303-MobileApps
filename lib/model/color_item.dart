import 'package:flutter/material.dart';

class ColorItem {
  Color color;
  String name;
  String hex;

  ColorItem({
    this.color,
    this.name,
    this.hex,
  });
}

var colorItemList = [
  ColorItem(
    color: Colors.red,
    name: 'Crimson',
    hex: '#DC143C',
  ),
  ColorItem(
    color: Colors.blue,
    name: 'Blue',
    hex: '#1E90FF',
  ),
  ColorItem(
    color: Colors.cyan,
    name: 'Cyan',
    hex: '#00FFFF',
  ),
  ColorItem(
    color: Colors.yellow,
    name: 'Yellow',
    hex: '#FFFF00',
  ),
  ColorItem(
    color: Colors.deepPurple,
    name: 'Deep Purple',
    hex: '#DC143C',
  ),
  ColorItem(
    color: Colors.deepOrange,
    name: 'Deep Orange',
    hex: '#FF7F50',
  ),
  ColorItem(
    color: Colors.green,
    name: 'Green',
    hex: '#228B22',
  ),
  ColorItem(
    color: Colors.grey,
    name: 'Grey',
    hex: '#808080',
  ),
  ColorItem(
    color: Colors.pink,
    name: 'Pink',
    hex: '#FF1493',
  ),
];
