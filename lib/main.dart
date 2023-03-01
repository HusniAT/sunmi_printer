import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sunmi Printer',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";

  @override
  void initState() {
    super.initState();

    _bindingPrinter().then((bool? isBind) async {
      SunmiPrinter.paperSize().then((int size) {
        print("paperSize Before $paperSize");
        setState(() {
          paperSize = size;
        });
        print("paperSize after $paperSize");
      });

      SunmiPrinter.printerVersion().then((String version) {
        print("printerVersion Before $printerVersion");

        setState(() {
          printerVersion = version;
        });
        print("printerVersion after $printerVersion");
      });

      SunmiPrinter.serialNumber().then((String serial) {
        print("serialNumber Before $serialNumber");

        setState(() {
          serialNumber = serial;
        });
        print("serialNumber after $serialNumber");
      });
      print("printBinded isBind Before $printBinded");

      setState(() {
        printBinded = isBind!;
      });
      print("printBinded isBind  after $printBinded");
    });
  }

  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Print Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Text("Print binded: " + printBinded.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Text("Paper size: " + paperSize.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Text("Serial number: " + serialNumber),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Text("Printer version: " + printerVersion),
            ),
            const Divider(
              thickness: 2,
              color: Colors.black,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // ElevatedButton(
                  //     onPressed: () async {
                  //       await SunmiPrinter.initPrinter();
                  //       await SunmiPrinter.startTransactionPrint(true);
                  //       await SunmiPrinter.printQRCode('https://github.com/brasizza/sunmi_printer');
                  //       await SunmiPrinter.lineWrap(2);
                  //       await SunmiPrinter.exitTransactionPrint(true);
                  //     },
                  //     child: const Text('Print qrCode')),
                  ElevatedButton(
                      onPressed: () async {
                        print(" start call Print barCode");
                        await SunmiPrinter.initPrinter();
                        await SunmiPrinter.startTransactionPrint(true);
                        await SunmiPrinter.printBarCode('1234567890', barcodeType: SunmiBarcodeType.CODE128, textPosition: SunmiBarcodeTextPos.TEXT_UNDER, height: 20);
                        await SunmiPrinter.lineWrap(2);
                        await SunmiPrinter.exitTransactionPrint(true);
                        print(" start call Print barCode");

                      },
                      child: const Text('Print barCode')),
                  // ElevatedButton(
                  //     onPressed: () async {
                  //       await SunmiPrinter.initPrinter();
                  //       await SunmiPrinter.startTransactionPrint(true);
                  //       await SunmiPrinter.line();
                  //       await SunmiPrinter.lineWrap(2);
                  //       await SunmiPrinter.exitTransactionPrint(true);
                  //     },
                  //     child: const Text('Print line')),
                  // ElevatedButton(
                  //     onPressed: () async {
                  //       await SunmiPrinter.lineWrap(2);
                  //     },
                  //     child: const Text('Wrap line')),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await SunmiPrinter.initPrinter();
                        await SunmiPrinter.startTransactionPrint(true);
                        await SunmiPrinter.printText('Hello I\'m bold', style: SunmiStyle(bold: true));
                        await SunmiPrinter.lineWrap(2);
                        await SunmiPrinter.exitTransactionPrint(true);
                      },
                      child: const Text('Bold Text')),
                  ElevatedButton(
                      onPressed: () async {
                        await SunmiPrinter.initPrinter();
                        await SunmiPrinter.startTransactionPrint(true);
                        await SunmiPrinter.printText('Very small!', style: SunmiStyle(fontSize: SunmiFontSize.XS));
                        await SunmiPrinter.lineWrap(2);
                        //await SunmiPrinter.co;

                        await SunmiPrinter.exitTransactionPrint(true);
                      },
                      child: const Text('Very small font')),
                  ElevatedButton(
                      onPressed: () async {
                        await SunmiPrinter.initPrinter();
                        await SunmiPrinter.startTransactionPrint(true);
                        await SunmiPrinter.printText('Very small!', style: SunmiStyle(fontSize: SunmiFontSize.SM));
                        await SunmiPrinter.lineWrap(2);
                        await SunmiPrinter.exitTransactionPrint(true);
                      },
                      child: const Text('Small font')),
                  ElevatedButton(
                      onPressed: () async {
                        await SunmiPrinter.initPrinter();
                        await SunmiPrinter.startTransactionPrint(true);
                        await SunmiPrinter.printText('Normal font', style: SunmiStyle(fontSize: SunmiFontSize.MD));

                        await SunmiPrinter.lineWrap(2);
                        await SunmiPrinter.exitTransactionPrint(true);
                      },
                      child: const Text('Normal font')),
                  ElevatedButton(
                      onPressed: () async {
                        await SunmiPrinter.initPrinter();
                        await SunmiPrinter.printText('Large font', style: SunmiStyle(fontSize: SunmiFontSize.LG));

                        await SunmiPrinter.lineWrap(2);
                        await SunmiPrinter.exitTransactionPrint(true);
                      },
                      child: const Text('Large font')),
                  ElevatedButton(
                      onPressed: () async {
                        await SunmiPrinter.initPrinter();
                        await SunmiPrinter.startTransactionPrint(true);
                        await SunmiPrinter.setFontSize(SunmiFontSize.XL);
                        await SunmiPrinter.printText('Very Large font!');
                        await SunmiPrinter.resetFontSize();
                        await SunmiPrinter.lineWrap(2);
                        await SunmiPrinter.exitTransactionPrint(true);
                      },
                      child: const Text('Very large font')),
                ],
              ),
            ),

            ////////////////////////////////////////
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       ElevatedButton(
            //           onPressed: () async {
            //             await SunmiPrinter.initPrinter();
            //             await SunmiPrinter.startTransactionPrint(true);
            //             await SunmiPrinter.printText('Align right', style: SunmiStyle(align: SunmiPrintAlign.RIGHT));
            //             await SunmiPrinter.lineWrap(2);
            //             await SunmiPrinter.exitTransactionPrint(true);
            //           },
            //           child: const Text('Align right')),
            //       ElevatedButton(
            //           onPressed: () async {
            //             await SunmiPrinter.initPrinter();
            //
            //             await SunmiPrinter.startTransactionPrint(true);
            //             await SunmiPrinter.printText('Align left', style: SunmiStyle(align: SunmiPrintAlign.LEFT));
            //
            //             await SunmiPrinter.lineWrap(2);
            //             await SunmiPrinter.exitTransactionPrint(true);
            //           },
            //           child: const Text('Align left')),
            //       ElevatedButton(
            //         onPressed: () async {
            //           await SunmiPrinter.initPrinter();
            //
            //           await SunmiPrinter.startTransactionPrint(true);
            //           await SunmiPrinter.printText(
            //             'Align center/ LARGE TEXT AND BOLD',
            //             style: SunmiStyle(align: SunmiPrintAlign.CENTER, bold: true, fontSize: SunmiFontSize.LG),
            //           );
            //
            //           await SunmiPrinter.lineWrap(2);
            //           await SunmiPrinter.exitTransactionPrint(true);
            //         },
            //         child: const Text('Align center'),
            //       ),
            //     ],
            //   ),
            // ),

            ////////////////////////////////////////
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       GestureDetector(
            //         onTap: () async {
            //           await SunmiPrinter.initPrinter();
            //
            //           Uint8List byte = await _getImageFromAsset('assets/images/dash.jpeg');
            //           await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
            //
            //           await SunmiPrinter.startTransactionPrint(true);
            //           await SunmiPrinter.printImage(byte);
            //           await SunmiPrinter.lineWrap(2);
            //           await SunmiPrinter.exitTransactionPrint(true);
            //         },
            //         child: Column(
            //           children: [
            //             Image.asset(
            //               'assets/images/dash.jpeg',
            //               width: 100,
            //             ),
            //             const Text('Print this image from asset!')
            //           ],
            //         ),
            //       ),
            //       GestureDetector(
            //         onTap: () async {
            //           await SunmiPrinter.initPrinter();
            //
            //           String url = 'https://avatars.githubusercontent.com/u/14101776?s=100';
            //           // convert image to Uint8List format
            //           Uint8List byte = (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();
            //           await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
            //           await SunmiPrinter.startTransactionPrint(true);
            //           await SunmiPrinter.printImage(byte);
            //           await SunmiPrinter.lineWrap(2);
            //           await SunmiPrinter.exitTransactionPrint(true);
            //         },
            //         child: Column(
            //           children: [Image.network('https://avatars.githubusercontent.com/u/14101776?s=100'), const Text('Print this image from WEB!')],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            ////////////////////////////////////////
            const Divider(
              thickness: 2,
              color: Colors.black,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            //     ElevatedButton(
            //         onPressed: () async {
            //           await SunmiPrinter.cut();
            //         },
            //         child: const Text('CUT PAPER')),
            //   ]),
            // ),
            ////////////////////////////////////////

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            //     ElevatedButton(
            //         onPressed: () async {
            //           final List<int> _escPos = await _customEscPos();
            //           await SunmiPrinter.initPrinter();
            //           await SunmiPrinter.startTransactionPrint(true);
            //           await SunmiPrinter.printRawData(Uint8List.fromList(_escPos));
            //           await SunmiPrinter.exitTransactionPrint(true);
            //         },
            //         child: const Text('Custom ESC/POS to print')),
            //   ]),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}


Future<Uint8List> readFileBytes(String path) async {
  ByteData fileData = await rootBundle.load(path);
  Uint8List fileUnit8List = fileData.buffer.asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
  return fileUnit8List;
}

Future<Uint8List> _getImageFromAsset(String iconPath) async {
  return await readFileBytes(iconPath);
}

Future<List<int>> _customEscPos() async {
  final profile = await CapabilityProfile.load();
  final generator = Generator(PaperSize.mm58, profile);
  List<int> bytes = [];

  bytes += generator.text('Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
  bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ', styles: const PosStyles(codeTable: 'CP1252'));
  bytes += generator.text('Special 2: blåbærgrød', styles: const PosStyles(codeTable: 'CP1252'));

  bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
  bytes += generator.text('Reverse text', styles: const PosStyles(reverse: true));
  bytes += generator.text('Underlined text', styles: const PosStyles(underline: true), linesAfter: 1);
  bytes += generator.text('Align left', styles: const PosStyles(align: PosAlign.left));
  bytes += generator.text('Align center', styles: const PosStyles(align: PosAlign.center));
  bytes += generator.text('Align right', styles: const PosStyles(align: PosAlign.right), linesAfter: 1);
  bytes += generator.qrcode('Barcode by escpos', size: QRSize.Size4, cor: QRCorrection.H);
  bytes += generator.feed(2);

  bytes += generator.row([
    PosColumn(
      text: 'col3',
      width: 3,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'col6',
      width: 6,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'col3',
      width: 3,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
  ]);

  bytes += generator.text('Text size 200%',
      styles: const PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ));

  bytes += generator.reset();
  bytes += generator.cut();

  return bytes;
}