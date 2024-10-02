import 'package:flutter/material.dart';
import 'package:testetecnicosti3/controllers/pedidos_controller.dart';
import 'package:testetecnicosti3/models/pedido.dart';

class PedidosStore extends ChangeNotifier {
  final PedidosController _controller = PedidosController();

  List<Pedido> pedidos = [];
  List<Pedido> filteredPedidos = [];
  bool isLoading = false;
  bool haveBoxData = true;
  String error = '';

  Future<void> carregarPedidos() async {
    isLoading = true;
    notifyListeners();

    try {
      final pedidos = await _controller.buscarPedidos();

      if (pedidos.isNotEmpty) {
        this.pedidos = pedidos;
        filteredPedidos = pedidos;
        haveBoxData = true;
      } else {
        haveBoxData = false;
      }

      notifyListeners();
    } on Exception catch (_, e) {
      print('Erro ao carregar pedidos do Hive: $e');
      error = e.toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> consultarPedidos() async {
    isLoading = true;
    notifyListeners();

    try {
      final pedidosApi = await _controller.fetchPedidosFromApi();

      if (pedidosApi.isNotEmpty) {
        await _controller.salvarPedidos(pedidosApi);
        await carregarPedidos();
      }

      notifyListeners();
    } on Exception catch (_, e) {
      print('Erro ao sincronizar pedidos com a API: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void filterPedidos(String query) {
    if (query.isEmpty) {
      filteredPedidos = pedidos;
    } else {
      filteredPedidos = pedidos.where((pedido) {
        final nomeCliente = pedido.cliente.nome!.toLowerCase();
        final razaoSocial = pedido.cliente.razaoSocial!.toLowerCase();
        final input = query.toLowerCase();

        return nomeCliente.contains(input) || razaoSocial.contains(input);
      }).toList();
    }

    notifyListeners();
  }
}
