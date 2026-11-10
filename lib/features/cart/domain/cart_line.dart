import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_line.freezed.dart';
part 'cart_line.g.dart';

/// What a line rents: a whole package or a single item.
enum CartLineKind { package, item }

/// Something the host means to rent for one event. The cart lives on the
/// phone until checkout turns it into bookings.
@freezed
abstract class CartLine with _$CartLine {
  const factory CartLine({
    required String eventId,
    required CartLineKind kind,

    /// The package or item id.
    required String refId,
    required String title,
    required int priceMinor,
    required String currency,
    String? vendorId,
    String? vendorName,
    @Default(1) int quantity,
  }) = _CartLine;

  factory CartLine.fromJson(Map<String, dynamic> json) =>
      _$CartLineFromJson(json);
}
