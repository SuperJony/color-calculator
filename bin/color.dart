/*
 * @Author: your name
 * @Date: 2020-08-18 10:13:43
 * @LastEditTime: 2020-08-27 14:10:07
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /color/bin/color.dart
 */

import 'package:color_models/color_models.dart';

void main() {
  var r = 97;
  var g = 77;
  var b = 190;

  var calc = CalculatorColor(r: r, g: g, b: b);
  print(calc.darkColor());
  print(calc.lightColor());
  print(calc.luma());
}

class CalculatorColor {
  CalculatorColor({this.r, this.g, this.b});
  final num r;
  final num g;
  final num b;

  num _luma;
  RgbColor _rgbColor;
  HsvColor _hsvColor;

  //计算颜色亮度 luma
  String luma() {
    _luma = (0.2126 * r + 0.7152 * g + 0.0722 * b) / 255;
    return _luma.toStringAsFixed(2);
  }

  //设置深色
  List darkColor() {
    num lumaDark = 0.32;
    var rgbColorValue = <num>[r, g, b];
    var hsvColorValue = <num>[];

    _luma = num.parse(luma());

    if (_luma > lumaDark) {
      _rgbColor = RgbColor.fromList(rgbColorValue);

      //将 rgb 转成 hsv
      _hsvColor = HsvColor.from(_rgbColor);
      hsvColorValue = _hsvColor.toList();

      //判断 s 是否大于 56，若小于则将 s 设为 56
      hsvColorValue[1] = hsvColorValue[1] < 56.0 ? 56.0 : hsvColorValue[1];
      _hsvColor = HsvColor.fromList(hsvColorValue);

      //将调整后的颜色转回 rgb
      _rgbColor = RgbColor.from(_hsvColor);
      rgbColorValue = _rgbColor.toList();

      //重新计算 luma
      _luma = (0.2126 * rgbColorValue[0] +
              0.7152 * rgbColorValue[1] +
              0.0722 * rgbColorValue[2]) /
          255;

      //若新色值的 luma 大于 lumaDark 则降低 luma
      if (_luma > lumaDark) {
        rgbColorValue[0] = (rgbColorValue[0] * lumaDark / _luma).round();
        rgbColorValue[1] = (rgbColorValue[1] * lumaDark / _luma).round();
        rgbColorValue[2] = (rgbColorValue[2] * lumaDark / _luma).round();
        return rgbColorValue;
      } else {
        return rgbColorValue;
      }
    }
    return rgbColorValue;
  }

  //设置浅色
  List lightColor() {
    num lumaLight = 0.88;
    var rgbColorValue = <num>[r, g, b];
    var hsvColorValue = <num>[];

    //计算颜色亮度 luma
    _luma = num.parse(luma());

    if (_luma < lumaLight) {
      _rgbColor = RgbColor.fromList(rgbColorValue);

      //将 rgb 转成 hsv
      _hsvColor = HsvColor.from(_rgbColor);
      hsvColorValue = _hsvColor.toList();

      hsvColorValue[2] = _hsvColor.isBlack ? lumaLight * 100 : hsvColorValue[2];
      //判断 s 是否大于 12，若大于则将 s 设为 12
      hsvColorValue[1] = hsvColorValue[1] > 12.0 ? 12.0 : hsvColorValue[1];
      _hsvColor = HsvColor.fromList(hsvColorValue);

      //将调整后的颜色转回 rgb
      _rgbColor = RgbColor.from(_hsvColor);
      rgbColorValue = _rgbColor.toList();

      //重新计算 luma
      _luma = (0.2126 * rgbColorValue[0] +
              0.7152 * rgbColorValue[1] +
              0.0722 * rgbColorValue[2]) /
          255;

      //若新色值的 luma 小于 0.88 则提高 luma
      if (_luma > 0 && _luma < lumaLight) {
        rgbColorValue[0] = (rgbColorValue[0] * lumaLight / _luma).round();
        rgbColorValue[1] = (rgbColorValue[1] * lumaLight / _luma).round();
        rgbColorValue[2] = (rgbColorValue[2] * lumaLight / _luma).round();
        return rgbColorValue;
      } else {
        return rgbColorValue;
      }
    }
    return rgbColorValue;
  }
}
