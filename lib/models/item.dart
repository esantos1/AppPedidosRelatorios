import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 2)
class Item {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String idProduto;

  @HiveField(2)
  final String nome;

  @HiveField(3)
  final int quantidade;

  @HiveField(4)
  final double valorUnitario;

  Item({
    required this.id,
    required this.idProduto,
    required this.nome,
    required this.quantidade,
    required this.valorUnitario,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'],
        idProduto: json['idProduto'],
        nome: json['nome'],
        quantidade: json['quantidade'],
        valorUnitario: (json['valorUnitario'] is int)
            ? double.parse(
                (json['valorUnitario'] as int).toDouble().toStringAsFixed(2))
            : double.parse(
                (json['valorUnitario'] as double).toStringAsFixed(2)),
      );
}
