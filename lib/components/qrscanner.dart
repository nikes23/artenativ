import 'package:artenativ/finditem.dart';
import 'package:artenativ/globals.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../services/api_service.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({Key? key, required this.overlayColour})
      : super(key: key);

  final Color overlayColour;

  @override
  Widget build(BuildContext context) {
    MobileScannerController cameraController = MobileScannerController();

    double scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 330.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.cameraFacingState,
                builder: (context, state, child) {
                  switch (state as CameraFacing) {
                    case CameraFacing.front:
                      return const Icon(Icons.flip_camera_ios_outlined);
                    case CameraFacing.back:
                      return const Icon(Icons.flip_camera_ios_outlined);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.switchCamera(),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(children: [
          MobileScanner(
              allowDuplicates: false,
              controller: cameraController,
              onDetect: (qrcode, args) {
                final String? qrcodeString = qrcode.rawValue;
                if (qrcodeString != null) {
                  qrcodeResult = qrcodeString;
                  debugPrint('QR Code found! $qrcodeString');

                  var uri = Uri.parse(qrcodeString);

                  int qrcodeInt =
                      int.parse(uri.queryParameters['id'].toString());

                  if (qrcodeInt <= artNrIntern! && qrcodeInt >= 10000000) {
                    APIService.findartikel(qrcodeInt).then(
                      (response) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FindItemScreen()));
                      },
                    );
                  } else if (qrcodeInt > artNrIntern!) {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Center(
                                  child: Text(
                                'Oops, ein Fehler ist aufgetreten!',
                                style: TextStyle(color: Color(0xFFF76A25)),
                              )),
                              content: const Text(
                                  "Die gescannte Nummer ist zu gro??"),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Container(
                                      height: 36.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: const Color(0xFFF76A25),
                                      ),
                                      child: MaterialButton(
                                          child: const Text(
                                            "OK",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                    ),
                                  ),
                                ),
                              ],
                            ));
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Center(
                                  child: Text(
                                'Oops, ein Fehler ist aufgetreten!',
                                style: TextStyle(color: Color(0xFFF76A25)),
                              )),
                              content: const Text(
                                  "Die gescannte Nummer ist zu klein"),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Container(
                                      height: 36.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: const Color(0xFFF76A25),
                                      ),
                                      child: MaterialButton(
                                          child: const Text(
                                            "OK",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                    ),
                                  ),
                                ),
                              ],
                            ));
                  }
                }
              }),
          ColorFiltered(
            colorFilter: ColorFilter.mode(overlayColour,
                BlendMode.srcOut), // This one will create the magic
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      backgroundBlendMode: BlendMode
                          .dstOut), // This one will handle background + difference out
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: scanArea,
                    width: scanArea,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: CustomPaint(
              foregroundPainter: BorderPainter(),
              child: SizedBox(
                width: scanArea + 25,
                height: scanArea + 25,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

// Creates the white borders
class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const width = 4.0;
    const radius = 20.0;
    const tRadius = 3 * radius;
    final rect = Rect.fromLTWH(
      width,
      width,
      size.width - 2 * width,
      size.height - 2 * width,
    );
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(radius));
    const clippingRect0 = Rect.fromLTWH(
      0,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect1 = Rect.fromLTWH(
      size.width - tRadius,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect2 = Rect.fromLTWH(
      0,
      size.height - tRadius,
      tRadius,
      tRadius,
    );
    final clippingRect3 = Rect.fromLTWH(
      size.width - tRadius,
      size.height - tRadius,
      tRadius,
      tRadius,
    );

    final path = Path()
      ..addRect(clippingRect0)
      ..addRect(clippingRect1)
      ..addRect(clippingRect2)
      ..addRect(clippingRect3);

    canvas.clipPath(path);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = width,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BarReaderSize {
  static double width = 200;
  static double height = 200;
}

class OverlayWithHolePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black54;
    canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
          Path()
            ..addOval(Rect.fromCircle(
                center: Offset(size.width - 44, size.height - 44), radius: 40))
            ..close(),
        ),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

@override
bool shouldRepaint(CustomPainter oldDelegate) {
  return false;
}
