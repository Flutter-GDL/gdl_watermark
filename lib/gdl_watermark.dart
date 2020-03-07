library gdl_watermark;

import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

/// A Calculator.
class FlutterGdl {

  static Widget showBottomWatermark(){
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Created with', style: GoogleFonts.dMSans(fontSize: 15)),
            SizedBox(
              width: 5,
            ),
            _heart(),
            SizedBox(
              width: 5,
            ),
            Text('for Flutter Guadalajara', style: GoogleFonts.dMSans(fontSize: 15)),
          ],
        ),
        // se puede haber usado safe area en todo el app
        // pero se hubiera visto mal arriba
        SizedBox(
          height: 20,
        )
      ],
    );

  }

  static Widget _heart({double width = 20, double height = 20}) {
    return Image.asset(
      "assets/corazon.png",
      width: width,
      height: height,
      package: "gdl_watermark",
    );
  }


}

