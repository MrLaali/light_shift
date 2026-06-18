import 'package:flutter/material.dart';
import '../models/light_profile.dart';

const List<LightProfile> lightProfiles = [
  LightProfile(
    type: LightType.white,
    name: 'White',
    color: Color(0xFFFFFFFF),
  ),
  LightProfile(
    type: LightType.red,
    name: 'Red',
    color: Color(0xFFFF0000),
  ),
  LightProfile(
    type: LightType.green,
    name: 'Green',
    color: Color(0xFF00FF00),
  ),
  LightProfile(
    type: LightType.blue,
    name: 'Blue',
    color: Color(0xFF0000FF),
  ),
  LightProfile(
    type: LightType.yellow,
    name: 'Yellow',
    color: Color(0xFFFFFF00),
  ),
  LightProfile(
    type: LightType.magenta,
    name: 'Magenta',
    color: Color(0xFFFF00FF),
  ),
  LightProfile(
    type: LightType.cyan,
    name: 'Cyan',
    color: Color(0xFF00FFFF),
  ),
];