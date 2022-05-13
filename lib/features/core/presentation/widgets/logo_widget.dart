import 'package:flutter/material.dart';

import '../../utils/size_config.dart';

class Logo extends StatelessWidget {
  const Logo(
      {Key? key,
      required this.greenLettersSize,
      required this.whitheLettersSize})
      : super(key: key);

  final double greenLettersSize;
  final double whitheLettersSize;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'U',
          style: TextStyle(
            color: Colors.green.shade700,
            fontSize: SizeConfig.blockSizeHorizontal * greenLettersSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'nder',
          style: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal * whitheLettersSize,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        Text(
          'C',
          style: TextStyle(
            color: Colors.green.shade700,
            fontSize: SizeConfig.blockSizeHorizontal * greenLettersSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'ontrol',
          style: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal * whitheLettersSize,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
