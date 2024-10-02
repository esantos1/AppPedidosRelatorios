import 'package:flutter_test/flutter_test.dart';
import 'package:testetecnicosti3/controllers/pedidos_controller.dart';

void main() {
  test('Teste de requisição de pedidos', () async {
    final pedidosController = PedidosController();

    final response = await pedidosController.fetchPedidosFromApi();
    print(response);

    expect(response.length, greaterThan(0));
  });
}
