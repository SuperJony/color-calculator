<!--
 * @Author: your name
 * @Date: 2020-08-18 10:13:43
 * @LastEditTime: 2020-08-18 16:00:52
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: /color/README.md
-->
A simple command-line application.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

# 书城取色规则
以书封颜色 rgb 为基准，通过换算得到 darkColor 与 lightColor

以 darkColor 为例，首先通过书封颜色的 rgb 算计算该颜色的亮度 luma，
```
luma = (0.2126 * r + 0.7152 * g + 0.0722 * b) / 255;
```
若 luma <= 0.4 则直接输出该 rgb 值

若 luma > 0.4, 则先将书封颜色 rbg 转为 hsv，判断 s = s < 56 ? 56 : s，将新的 hsv 再转回 rgb，对新对色值再次计算 luma' 并判断 luma' > 0.4

若 luma' <= 0.4 则输出该新的 rgb 值

若 luma' > 0.4 则通过等比例缩小 r,g,b 的值降低 luma 大小，并输出该新的 rgb值

---

计算 lightColor 同理，仅对 luma 的判断条件和 s 的取值做修改
