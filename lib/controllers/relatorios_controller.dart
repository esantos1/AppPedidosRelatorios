import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:testetecnicosti3/models/pedido.dart';

class RelatoriosController {
  Future<Map<String, int>> produtosMaisVendidos() async {
    final box = await Hive.openBox<Pedido>('pedidos');
    Map<String, int> produtoQuantidades = {};

    for (final pedido in box.values) {
      for (final item in pedido.itens) {
        if (produtoQuantidades.containsKey(item.nome)) {
          produtoQuantidades[item.nome] =
              produtoQuantidades[item.nome]! + item.quantidade;
        } else {
          produtoQuantidades[item.nome] = item.quantidade;
        }
      }
    }

    final sortedEntries = produtoQuantidades.entries.toList();
    sortedEntries.sort((a, b) => b.value.compareTo(a.value));

    Map<String, int> sortedProdutoQuantidades = {
      for (final entry in sortedEntries) entry.key: entry.value
    };

    return sortedProdutoQuantidades;
  }

  Future<Map<String, Map<String, double>>> totalizacaoFormasPagamento() async {
    final box = await Hive.openBox<Pedido>('pedidos');
    Map<String, Map<String, double>> pagamentoPorDia = {};

    for (final pedido in box.values) {
      String data = DateFormat('dd/MM/yyyy').format(pedido.dataCriacao);

      for (final pagamento in pedido.pagamento) {
        String formaPagamento = pagamento.nome;

        if (!pagamentoPorDia.containsKey(data)) {
          pagamentoPorDia[data] = {};
        }

        if (pagamentoPorDia[data]!.containsKey(formaPagamento)) {
          pagamentoPorDia[data]![formaPagamento] =
              pagamentoPorDia[data]![formaPagamento]! + pagamento.valor;
        } else {
          pagamentoPorDia[data]![formaPagamento] = pagamento.valor;
        }
      }
    }

    final sortedEntries = pagamentoPorDia.entries.toList();

    sortedEntries.sort((a, b) {
      DateTime dataA = DateFormat('dd/MM/yyyy').parse(a.key);
      DateTime dataB = DateFormat('dd/MM/yyyy').parse(b.key);
      return dataB.compareTo(dataA);
    });

    Map<String, Map<String, double>> sortedPagamentoPorDia = {
      for (final entry in sortedEntries) entry.key: entry.value
    };

    return sortedPagamentoPorDia;
  }

  Future<Map<String, Map<String, dynamic>>> totalizacaoVendasCidade() async {
    final box = await Hive.openBox<Pedido>('pedidos');
    Map<String, Map<String, dynamic>> vendasPorCidade = {};

    for (final pedido in box.values) {
      final cidade = pedido.enderecoEntrega.cidade;

      if (!vendasPorCidade.containsKey(cidade)) {
        vendasPorCidade[cidade] = {'quantidadePedidos': 0, 'valorTotal': 0.0};
      }

      vendasPorCidade[cidade]!['quantidadePedidos'] =
          vendasPorCidade[cidade]!['quantidadePedidos'] + 1;
      vendasPorCidade[cidade]!['valorTotal'] =
          vendasPorCidade[cidade]!['valorTotal'] + pedido.valorTotal;
    }

    return vendasPorCidade;
  }

  Future<Map<String, Map<String, dynamic>>>
      totalizacaoVendasFaixaEtaria() async {
    final box = await Hive.openBox<Pedido>('pedidos');
    Map<String, Map<String, dynamic>> vendasPorFaixaEtaria = {
      '0-18': {'quantidade': 0, 'valorTotal': 0.0},
      '19-35': {'quantidade': 0, 'valorTotal': 0.0},
      '36-50': {'quantidade': 0, 'valorTotal': 0.0},
      '51+': {'quantidade': 0, 'valorTotal': 0.0},
    };

    for (final pedido in box.values) {
      int idade = _calcularIdade(pedido.cliente.dataNascimento);
      String faixaEtaria = _definirFaixaEtaria(idade);

      vendasPorFaixaEtaria[faixaEtaria]!['quantidade'] += 1;
      vendasPorFaixaEtaria[faixaEtaria]!['valorTotal'] += pedido.valorTotal;
    }

    return vendasPorFaixaEtaria;
  }

  int _calcularIdade(DateTime dataNascimento) {
    final dataAtual = DateTime.now();
    final verifyBirthday = dataAtual.month < dataNascimento.month ||
        (dataAtual.month == dataNascimento.month &&
            dataAtual.day < dataNascimento.day);
    int idade = dataAtual.year - dataNascimento.year;

    if (verifyBirthday) {
      idade--;
    }

    return idade;
  }

  String _definirFaixaEtaria(int idade) {
    if (idade <= 18) {
      return '0-18';
    } else if (idade <= 35) {
      return '19-35';
    } else if (idade <= 50) {
      return '36-50';
    } else {
      return '51+';
    }
  }
}
