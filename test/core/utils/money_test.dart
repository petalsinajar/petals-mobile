import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/utils/money.dart';

void main() {
  group('MoneyFormat.format', () {
    test('drops .00 on whole amounts', () {
      expect(MoneyFormat.format(125000, 'GHS'), 'GH₵1,250');
    });

    test('keeps pesewas when present', () {
      expect(MoneyFormat.format(1250, 'GHS'), 'GH₵12.50');
    });

    test('formats negatives', () {
      expect(MoneyFormat.format(-500, 'GHS'), '-GH₵5');
    });

    test('compact for large amounts', () {
      expect(MoneyFormat.format(1500000, 'GHS', compact: true), 'GH₵15K');
      expect(MoneyFormat.format(120000000, 'GHS', compact: true), 'GH₵1.2M');
    });

    test('compact leaves small amounts alone', () {
      expect(MoneyFormat.format(45000, 'GHS', compact: true), 'GH₵450');
    });

    test('zero-decimal currencies have no minor units', () {
      expect(MoneyFormat.minorDigits('XOF'), 0);
      expect(MoneyFormat.format(5000, 'XOF'), 'XOF 5,000');
    });
  });

  group('Money', () {
    const a = Money(48000, 'GHS');

    test('adds and multiplies in minor units', () {
      expect(a + const Money(2000, 'GHS'), const Money(50000, 'GHS'));
      expect(a * 3, const Money(144000, 'GHS'));
    });

    test('percent rounds to the nearest minor unit', () {
      expect(a.percent(30), const Money(14400, 'GHS'));
      expect(const Money(333, 'GHS').percent(30), const Money(100, 'GHS'));
    });

    test('refuses to mix currencies', () {
      expect(() => a + const Money(100, 'USD'), throwsArgumentError);
    });
  });
}
