import 'package:flutter/material.dart';

import '../configure/constants.dart';


double getScreenHeight(context, double heightvalue) {
  return heightvalue *
      ((MediaQuery.of(context).size.height) / AppConstants.defaultHeight);
}

double getScreenWidth(context, double widthvalue) {
  return ((MediaQuery.of(context).size.width) / AppConstants.defaultWidth) *
      widthvalue;
}
