import 'package:flutter/material.dart';
import 'package:forget_password/utils/debug_printer.dart';

class Dimension {
  static double? _deviceScreenWidth;
  static double? _deviceScreenHeight;
  static double? _blockSizeHorizantal = 0;
  static double? _blockSizeVertical = 0;

  static double widthMultiplier = 0;
  static double heightMultiplier = 0;
  static double textMultiplier = 0;
  static double imageSizeMultiplier = 0;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _deviceScreenWidth = constraints.maxWidth;
      _deviceScreenHeight = constraints.maxHeight;
    } else if (orientation == Orientation.landscape) {
      _deviceScreenWidth = constraints.maxHeight;
      _deviceScreenHeight = constraints.maxWidth;
    }
    
    _blockSizeHorizantal = _deviceScreenWidth! / 100;
    _blockSizeVertical = _deviceScreenHeight! / 100;

    widthMultiplier = _blockSizeHorizantal!;
    heightMultiplier = _blockSizeVertical!;
    textMultiplier = _blockSizeHorizantal!;
    imageSizeMultiplier = _blockSizeHorizantal!;

    DebugPrinter.log("Device Screen Horizantal Parts : $widthMultiplier");
    DebugPrinter.log("Device Screen Vertical Parts : $heightMultiplier");
  }
}
