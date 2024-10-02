import 'package:hive/hive.dart';

import 'package:testetecnicosti3/models/cliente.dart';
import 'package:testetecnicosti3/models/endereco_entrega.dart';
import 'package:testetecnicosti3/models/item.dart';
import 'package:testetecnicosti3/models/pagamento.dart';

part 'pedido.g.dart';

@HiveType(typeId: 0)
class Pedido {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int numero;

  @HiveField(2)
  final DateTime dataCriacao;

  @HiveField(3)
  final DateTime dataAlteracao;

  @HiveField(4)
  final String status;

  @HiveField(5)
  final int desconto;

  @HiveField(6)
  final int frete;

  @HiveField(7)
  final double subTotal;

  @HiveField(8)
  final double valorTotal;

  @HiveField(9)
  final Cliente cliente;

  @HiveField(10)
  final EnderecoEntrega enderecoEntrega;

  @HiveField(11)
  final List<Item> itens;

  @HiveField(12)
  final List<Pagamento> pagamento;

  Pedido({
    required this.id,
    required this.numero,
    required this.dataCriacao,
    required this.dataAlteracao,
    required this.status,
    required this.desconto,
    required this.frete,
    required this.subTotal,
    required this.valorTotal,
    required this.cliente,
    required this.enderecoEntrega,
    required this.itens,
    required this.pagamento,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
        id: json['id'],
        numero: json['numero'],
        dataCriacao: DateTime.parse(json['dataCriacao']),
        dataAlteracao: DateTime.parse(json['dataAlteracao']),
        status: json['status'],
        desconto: (json['desconto'] is int)
            ? (json['desconto'] as int)
            : (json['desconto'] is double)
                ? (json['desconto'] as double).toInt()
                : 0,
        frete: (json['frete'] is int)
            ? (json['frete'] as int)
            : (json['frete'] is double)
                ? (json['frete'] as double).toInt()
                : 0,
        subTotal: (json['subTotal'] != null)
            ? (json['subTotal'] is int)
                ? double.parse(
                    (json['subTotal'] as int).toDouble().toStringAsFixed(2))
                : double.parse((json['subTotal'] as double).toStringAsFixed(2))
            : 0.0,
        valorTotal: (json['valorTotal'] is int)
            ? double.parse(
                (json['valorTotal'] as int).toDouble().toStringAsFixed(2))
            : double.parse(
                (json['valorTotal'] as double).toStringAsFixed(2),
              ),
        cliente: Cliente.fromJson(json['cliente']),
        enderecoEntrega: EnderecoEntrega.fromJson(json['enderecoEntrega']),
        itens:
            (json['itens'] as List).map((item) => Item.fromJson(item)).toList(),
        pagamento: (json['pagamento'] as List)
            .map((pag) => Pagamento.fromJson(pag))
            .toList(),
      );

  @override
  String toString() {
    return 'Pedido(id: $id, numero: $numero, dataCriacao: $dataCriacao, dataAlteracao: $dataAlteracao, status: $status, desconto: $desconto, frete: $frete, subTotal: $subTotal, valorTotal: $valorTotal, cliente: $cliente, enderecoEntrega: $enderecoEntrega, itens: $itens, pagamento: $pagamento)';
  }
}
