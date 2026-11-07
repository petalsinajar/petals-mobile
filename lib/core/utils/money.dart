import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

/// Money as the backend sends it: integer minor units + ISO 4217 currency.
/// Never a double.
@immutable
class Money {
  const Money(this.amountMinor, this.currency);

  const Money.zero(this.currency) : amountMinor = 0;

  final int amountMinor;
  final String currency;

  Money operator +(Money other) {
    _assertSameCurrency(other);
    return Money(amountMinor + other.amountMinor, currency);
  }

  Money operator -(Money other) {
    _assertSameCurrency(other);
    return Money(amountMinor - other.amountMinor, currency);
  }

  Money operator *(int quantity) => Money(amountMinor * quantity, currency);

  /// Percentage of this amount, rounded to the nearest minor unit
  /// (e.g. a 30% deposit).
  Money percent(int percent) =>
      Money((amountMinor * percent / 100).round(), currency);

  String format({bool compact = false}) =>
      MoneyFormat.format(amountMinor, currency, compact: compact);

  void _assertSameCurrency(Money other) {
    if (other.currency != currency) {
      throw ArgumentError('Cannot combine $currency with ${other.currency}');
    }
  }

  @override
  bool operator ==(Object other) =>
      other is Money &&
      other.amountMinor == amountMinor &&
      other.currency == currency;

  @override
  int get hashCode => Object.hash(amountMinor, currency);

  @override
  String toString() => 'Money($amountMinor $currency)';
}

/// The only place money is turned into text.
abstract final class MoneyFormat {
  static const _symbols = {
    'GHS': 'GH₵',
    'NGN': '₦',
    'KES': 'KSh',
    'USD': r'$',
    'EUR': '€',
    'GBP': '£',
  };

  /// Currencies without minor units. Everything else has 2.
  static const _zeroDecimal = {'XOF', 'XAF', 'JPY', 'RWF', 'UGX'};

  static int minorDigits(String currency) =>
      _zeroDecimal.contains(currency) ? 0 : 2;

  static String symbol(String currency) => _symbols[currency] ?? '$currency ';

  /// `GH₵1,250` · `GH₵12.50` · compact: `GH₵1.2K`.
  ///
  /// Whole amounts drop the `.00` — prices in a social feed read cleaner.
  static String format(
    int amountMinor,
    String currency, {
    bool compact = false,
  }) {
    final digits = minorDigits(currency);
    final divisor = digits == 0 ? 1 : 100;
    final major = amountMinor / divisor;
    final sym = symbol(currency);

    if (compact && amountMinor.abs() >= 1000 * divisor) {
      return NumberFormat.compactCurrency(
        symbol: sym,
        decimalDigits: 1,
      ).format(major).replaceFirst('.0', '');
    }

    final showDecimals = digits > 0 && amountMinor % divisor != 0;
    return NumberFormat.currency(
      symbol: sym,
      decimalDigits: showDecimals ? digits : 0,
    ).format(major);
  }
}
