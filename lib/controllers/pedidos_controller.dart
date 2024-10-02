import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:testetecnicosti3/models/pedido.dart';

class PedidosController {
  final apiUrl = 'https://desafiotecnicosti3.azurewebsites.net/pedido';

  Future<List<Pedido>> fetchPedidosFromApi() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final pedidosJson = List.from(jsonDecode(response.body));

      return pedidosJson.map((json) => Pedido.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar pedidos');
    }
  }

  Future<void> salvarPedidos(List<Pedido> pedidos) async {
    final box = await Hive.openBox<Pedido>('pedidos');

    await box.clear();

    for (var pedido in pedidos) {
      await box.add(pedido);
    }
  }

  Future<List<Pedido>> buscarPedidos() async {
    final box = await Hive.openBox<Pedido>('pedidos');

    return box.values.toList();
  }

  Future<List<Pedido>> buscarPorCliente(String nomeCliente) async {
    final box = await Hive.openBox<Pedido>('pedidos');

    return box.values
        .where((pedido) => pedido.cliente.nome!
            .toLowerCase()
            .contains(nomeCliente.toLowerCase()))
        .toList();
  }
}
