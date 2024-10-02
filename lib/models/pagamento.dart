import 'package:hive/hive.dart';

part 'pagamento.g.dart';

@HiveType(typeId: 3)
class Pagamento {
  @HiveField(0)
  late final String id;

  @HiveField(1)
  late final int parcela;

  @HiveField(2)
  late final double valor;

  @HiveField(3)
  late final String codigo;

  @HiveField(4)
  late final String nome;

  Pagamento({
    required this.id,
    required this.parcela,
    required this.valor,
    required this.codigo,
    required this.nome,
  });

  factory Pagamento.fromJson(Map<String, dynamic> json) => Pagamento(
        id: json['id'],
        parcela: json['parcela'],
        valor: (json['valor'] is int)
            ? double.parse((json['valor'] as int).toDouble().toStringAsFixed(2))
            : double.parse((json['valor'] as double).toStringAsFixed(2)),
        codigo: json['codigo'],
        nome: json['nome'],
      );
}
