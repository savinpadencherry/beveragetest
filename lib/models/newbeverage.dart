// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class NewBeverage extends Equatable {
  final String id;
  final String name;
  final String instructions;
  final String type;
  final String strGlass;
  final String imageUrl;
  NewBeverage({
    required this.id,
    required this.name,
    required this.instructions,
    required this.type,
    required this.strGlass,
    required this.imageUrl,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      instructions,
      type,
      strGlass,
      imageUrl,
    ];
  }
}
