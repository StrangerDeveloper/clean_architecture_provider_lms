import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SpaceXY on num{

  Widget get spaceX => SizedBox(width: 1.0.sw > 600 ? toDouble().w : toDouble());

  Widget get spaceY => SizedBox(height: 1.0.sw > 600 ? toDouble().h : toDouble());
}