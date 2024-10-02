import 'package:hive/hive.dart';

part 'cliente.g.dart';

@HiveType(typeId: 1)
class Cliente {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? cnpj;

  @HiveField(2)
  final String? cpf;

  @HiveField(3)
  final String? nome;

  @HiveField(4)
  final String? razaoSocial;

  @HiveField(5)
  final String email;

  @HiveField(6)
  final DateTime dataNascimento;

  Cliente({
    required this.id,
    this.cnpj,
    this.cpf,
    this.nome,
    this.razaoSocial,
    required this.email,
    required this.dataNascimento,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        id: json['id'],
        cnpj: json['cnpj'],
        cpf: json['cpf'],
        nome: json['nome'],
        razaoSocial: json['razaoSocial'],
        email: json['email'],
        dataNascimento: DateTime.parse(json['dataNascimento']),
      );
}
