import 'package:esc_pos_utils/esc_pos_utils.dart';

class PrinterService {
  static Future<List<int>> generateReceipt({
    required List<Map<String, dynamic>> items,
    required double subtotal,
    required double vat,
    required double total,
  }) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];

    bytes += generator.text('TakeawayPro POS',
        styles: PosStyles(align: PosAlign.center, bold: true, height: PosTextSize.size2));
    bytes += generator.text('------------------------------');

    for (var item in items) {
      bytes += generator.text('${item['name']} x${item['quantity']}');
      bytes += generator.text('£${(item['price'] * item['quantity']).toStringAsFixed(2)}',
          styles: PosStyles(align: PosAlign.right));
    }

    bytes += generator.text('------------------------------');
    bytes += generator.text('Subtotal: £${subtotal.toStringAsFixed(2)}');
    bytes += generator.text('VAT (20%): £${vat.toStringAsFixed(2)}');
    bytes += generator.text('Total: £${total.toStringAsFixed(2)}',
        styles: PosStyles(bold: true, align: PosAlign.right));

    bytes += generator.feed(2);
    bytes += generator.cut();

    return bytes;
  }
}
