import 'package:intl/intl.dart';
final String api_url = "http://146.190.109.66:8000";
// final String api_url = "http://0.0.0.0:8000";



String formatCurrency(int amount) {
  return NumberFormat.currency(
      locale: 'id_ID', // Use the Indonesian locale
      decimalDigits: 2, // Use 2 decimal places
    )
      .format(amount);
}