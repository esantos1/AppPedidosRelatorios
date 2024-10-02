import 'package:flutter/material.dart';
import 'package:testetecnicosti3/controllers/relatorios_controller.dart';
import 'package:testetecnicosti3/enum/exibicao.dart';

class RelatoriosStore extends ChangeNotifier {
  final _controller = RelatoriosController();

  Exibicao selectedExibicao = Exibicao.maisVendidos;
  bool isLoading = false;
  String? error;
  Map<String, dynamic> list = {};

  void changeExibicao(Exibicao? newValue) {
    selectedExibicao = newValue!;
    carregarRelatorio();

    notifyListeners();
  }

  Future<void> carregarRelatorio() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      switch (selectedExibicao) {
        case Exibicao.maisVendidos:
          list = await _controller.produtosMaisVendidos();
          break;
        case Exibicao.totalizacaoFormasPagamento:
          list = await _controller.totalizacaoFormasPagamento();
          break;
        case Exibicao.totalizacaoVendasCidade:
          list = await _controller.totalizacaoVendasCidade();
          break;
        case Exibicao.totalizacaoVendasFaixaEtaria:
          list = await _controller.totalizacaoVendasFaixaEtaria();
          break;
        default:
          list = {};
      }
    } on Exception catch (_, e) {
      error = 'Erro ao carregar dados: $e';
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
