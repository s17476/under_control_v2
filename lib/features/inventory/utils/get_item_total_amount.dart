import '../domain/entities/item.dart';

/// Calculates total amount of given item in all locations.
///
/// Returns [double].
double getItemTotalAmount(Item item) {
  double result = 0;

  for (var amountInLocation in item.amountInLocations) {
    result += amountInLocation.amount;
  }

  return result;
}
