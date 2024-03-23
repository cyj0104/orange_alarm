import "package:flutter/material.dart";
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


class BarcodeScanMission {
  final Function() stopAlarmSound;

  BarcodeScanMission({
    required this.stopAlarmSound,
  });

  Future<void> barcodeScan(BuildContext context) async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', // 바코드 스캔바 색상(#ff6666 : 빨간색)
        '취소', // 취소 버튼 텍스트
        true, // 플래시 토글
        ScanMode.BARCODE, // 스캔 모드(바코드 또는 QR 코드) 선택
      );
    } catch (e) {
      barcodeScanRes = 'Failed to get platform version.';
    }

    stopAlarmSound();

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Barcode Result: $barcodeScanRes'),
    //   ),
    // );
  }
}