// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum StatusTag { IN_PROGRESS, COMPLETED }

abstract final class ScreenSize {
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;
}

abstract final class AppSizedBox {
  static Widget empty() => const SizedBox();

  static Widget height30() => const SizedBox(
        height: 30,
      );

  static Widget height20() => const SizedBox(
        height: 20,
      );

  static Widget height16() => const SizedBox(
        height: 16,
      );

  static Widget height10() => const SizedBox(
        height: 10,
      );

  static Widget height2() => const SizedBox(
        height: 2,
      );

  static Widget height4() => const SizedBox(
        height: 4,
      );

  static Widget width50() => const SizedBox(
        width: 50,
      );

  static Widget width20() => const SizedBox(
        width: 20,
      );

  static Widget hwidth16() => const SizedBox(
        width: 16,
      );

  static Widget width10() => const SizedBox(
        width: 10,
      );

  static Widget width6() => const SizedBox(
        width: 6,
      );

  static Widget width4() => const SizedBox(
        width: 4,
      );
}
