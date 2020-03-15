library gdl_watermark;

import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

/// Este enum sirve para controlar lo que regrese el watermark
enum ContainerType { none, expanded, flexible }

/// flutterGDL
///
/// Esta clase sera base para futuras adiciones para nuestro
/// meetup, sera en su mayoria solo un watermark
///
/// containerType se usa para controlar el tipo de widget ya sea una Columna basica
///
/// *[Column] usando ContainerType.none
/// *[Flexible] usando ContainerType.flexible
/// *[Expanded] usando ContainerType.expanded
///
/// flex es el numero de Flex correspondiente a [Flexible] o [Expanded]
///
/// bottomPadding es para creare un margen debajo del widget de 20 'pixeles logicos'
/// es decir pixeles independientes de la resolucion
///
/// https://api.flutter.dev/flutter/dart-ui/Window/devicePixelRatio.html
///
///
/// Esta clase no guarda variables
class FlutterGdl {
  static Widget showBottomWatermark({
    int flex = 1,
    ContainerType containerType = ContainerType.none,
    bool bottomPadding = true,
  }) {
    if (containerType == ContainerType.none)
      return _concreteData(bottomPadding);

    return (containerType == ContainerType.expanded)
        ? Expanded(
            flex: flex,
            child: _concreteData(bottomPadding),
          )
        : Flexible(
            flex: flex,
            child: _concreteData(bottomPadding),
          );
  }

  /// Los datos concretos sin ser modificados
  ///
  /// bool bottomPadding:  true si agregaremos 20 pixeles logicos debajo del
  /// widget
  ///
  static Widget _concreteData(bool bottomPadding) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Created with', style: GoogleFonts.dMSans(fontSize: 15)),
            _heart(),
            Text('for Flutter Guadalajara',
                style: GoogleFonts.dMSans(fontSize: 15)),
          ],
        ),
        // se puede haber usado safe area en todo el app
        // pero se hubiera visto mal arriba en los apps que tienen notch (hueco)
        (bottomPadding == true)
            ? SizedBox(
                height: 20,
              )
            : Container()
      ],
    );
  }

  /// funcion interna y privada al plupara devolver imagen
  ///
  ///
  static Widget _heart({double width = 20, double height = 20}) {
    return Image.asset(
      "assets/corazon.png",
      width: width,
      height: height,
      package: "gdl_watermark",
    );
  }
}
