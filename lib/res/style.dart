import 'package:flutter/material.dart';

import '../res/colors.dart';
import '../res/dimens.dart';

class TextStyles {
  static TextStyle listTitle = TextStyle(
    fontSize: Dimens.font_sp16,
    color: LocalColors.text_dark,
    fontWeight: FontWeight.bold,
  );
  static TextStyle listContent = TextStyle(
    fontSize: Dimens.font_sp14,
    color: LocalColors.text_normal,
  );
  static TextStyle listExtra = TextStyle(
    fontSize: Dimens.font_sp12,
    color: LocalColors.text_gray,
  );
}
