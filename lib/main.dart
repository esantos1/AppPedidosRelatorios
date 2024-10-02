import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:testetecnicosti3/models/cliente.dart';
import 'package:testetecnicosti3/models/endereco_entrega.dart';
import 'package:testetecnicosti3/models/item.dart';
import 'package:testetecnicosti3/models/pagamento.dart';
import 'package:testetecnicosti3/models/pedido.dart';
import 'package:testetecnicosti3/views/main_view.dart';
import 'package:testetecnicosti3/views/pedidos_details_view.dart';
import 'package:testetecnicosti3/views/pedidos_view.dart';
import 'package:testetecnicosti3/views/relatorios_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initializeDateFormatting('pt_BR', null);

  Hive.registerAdapter(PedidoAdapter());
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(PagamentoAdapter());
  Hive.registerAdapter(ClienteAdapter());
  Hive.registerAdapter(EnderecoEntregaAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pedidos STi3',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => MainView(),
          '/pedidos': (context) => PedidosView(),
          '/relatorios': (context) => RelatoriosView(),
          '/pedidos-details': (context) => PedidosDetailsView(),
        },
      );
}
