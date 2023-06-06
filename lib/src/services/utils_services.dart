import 'package:intl/intl.dart';

class UtilServices {
  // retorna o valor string formatado para valor
  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: "pt_BR");
    return numberFormat.format(price);
  }
}
