import 'package:hive/hive.dart';

part 'endereco_entrega.g.dart';

@HiveType(typeId: 4)
class EnderecoEntrega extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String endereco;

  @HiveField(2)
  final String numero;

  @HiveField(3)
  final String cep;

  @HiveField(4)
  final String? bairro;

  @HiveField(5)
  final String cidade;

  @HiveField(6)
  final String estado;

  @HiveField(7)
  final String? complemento;

  @HiveField(8)
  final String? referencia;

  EnderecoEntrega({
    required this.id,
    required this.endereco,
    required this.numero,
    required this.cep,
    this.bairro,
    required this.cidade,
    required this.estado,
    this.complemento,
    this.referencia,
  });

  factory EnderecoEntrega.fromJson(Map<String, dynamic> json) =>
      EnderecoEntrega(
        id: json['id'],
        endereco: json['endereco'],
        numero: json['numero'],
        cep: json['cep'],
        bairro: json['bairro'],
        cidade: json['cidade'],
        estado: json['estado'],
        complemento: json['complemento'],
        referencia: json['referencia'],
      );
}
