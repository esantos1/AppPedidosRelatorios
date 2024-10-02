import 'package:intl/intl.dart';

String formatBrl(double n) => NumberFormat.currency(
      locale: 'pt-BR',
      symbol: 'R\$',
      decimalDigits: 2,
    ).format(n);
