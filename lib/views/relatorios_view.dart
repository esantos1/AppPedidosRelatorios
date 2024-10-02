import 'package:flutter/material.dart';
import 'package:testetecnicosti3/enum/exibicao.dart';
import 'package:testetecnicosti3/store/relatorios_store.dart';
import 'package:testetecnicosti3/utils/currency_format.dart';

class RelatoriosView extends StatefulWidget {
  const RelatoriosView({super.key});

  @override
  State<RelatoriosView> createState() => _RelatoriosViewState();
}

class _RelatoriosViewState extends State<RelatoriosView> {
  final store = RelatoriosStore();

  @override
  void initState() {
    super.initState();

    store.changeExibicao(Exibicao.maisVendidos);
    store.carregarRelatorio();
  }

  List<DropdownMenuItem<Exibicao>> getDropdownMenuItems() {
    return Exibicao.values
        .map((item) => DropdownMenuItem<Exibicao>(
              value: item,
              child: Text(getExibicaoText(item)),
            ))
        .toList();
  }

  String getExibicaoText(Exibicao exibicao) {
    switch (exibicao) {
      case Exibicao.maisVendidos:
        return 'Mais Vendidos';
      case Exibicao.totalizacaoFormasPagamento:
        return 'Totalização por Formas de Pagamento';
      case Exibicao.totalizacaoVendasCidade:
        return 'Totalização de Vendas por Cidade';
      case Exibicao.totalizacaoVendasFaixaEtaria:
        return 'Totalização de Vendas por Faixa Etária';
      default:
        throw Exception('Opcão inválida.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        Widget? body;

        if (store.isLoading) {
          body = Center(child: CircularProgressIndicator());
        }

        if (store.list.isNotEmpty) {
          switch (store.selectedExibicao) {
            case Exibicao.maisVendidos:
              body = buildMaisVendidos(store.list as Map<String, int>);
            case Exibicao.totalizacaoFormasPagamento:
              body = buildTotalizacaoFormasPagamento(
                  store.list as Map<String, Map<String, double>>);
            case Exibicao.totalizacaoVendasCidade:
              body = buildTotalizacaoVendasCidade(
                  store.list as Map<String, Map<String, dynamic>>);
            case Exibicao.totalizacaoVendasFaixaEtaria:
              body = buildTotalizacaoVendasFaixaEtaria(
                  store.list as Map<String, Map<String, dynamic>>);
            default:
              body = Center(child: Text('Opção inválida.'));
          }
        }

        if (store.error != null) {
          body = Center(
            child: Column(
              children: [
                Text(store.error!),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => store.changeExibicao(store.selectedExibicao),
                  child: Text('Tentar novamente'),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Exibicao>(
                    hint: Text('Selecione uma Exibição'),
                    value: store.selectedExibicao,
                    items: getDropdownMenuItems(),
                    onChanged: store.changeExibicao,
                    isExpanded: true,
                    iconSize: 32,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).primaryColor,
                    ),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ),
              Expanded(child: body ?? Container()),
            ],
          ),
        );
      },
    );
  }

  Widget buildMaisVendidos(Map<String, int> produtosMaisVendidos) =>
      ListView.builder(
        itemCount: produtosMaisVendidos.length,
        itemBuilder: (context, index) {
          final produto = produtosMaisVendidos.keys.elementAt(index);
          final quantidade = produtosMaisVendidos[produto]!;

          return Card.outlined(
            child: ListTile(
              title: Text(produto),
              subtitle: Text('Quantidade vendida: $quantidade'),
            ),
          );
        },
      );

  Widget buildTotalizacaoFormasPagamento(
    Map<String, Map<String, double>> dados,
  ) =>
      ListView(
        children: dados.keys
            .map((data) => ExpansionTile(
                  title: Text('Data: $data'),
                  children: dados[data]!
                      .entries
                      .map((formaPagamento) => ListTile(
                            title: Text(
                                'Forma de Pagamento: ${formaPagamento.key}'),
                            subtitle: Text(
                              'Valor: ${formatBrl(formaPagamento.value)}',
                            ),
                          ))
                      .toList(),
                ))
            .toList(),
      );

  Widget buildTotalizacaoVendasCidade(
          Map<String, Map<String, dynamic>> dados) =>
      ListView.builder(
        itemCount: dados.length,
        itemBuilder: (context, index) {
          final cidade = dados.keys.elementAt(index);
          final info = dados[cidade];

          return Card.outlined(
            child: ListTile(
              title: Text('Cidade: $cidade'),
              subtitle: Text(
                'Quantidade de Pedidos: ${info!['quantidadePedidos']} \nValor Total: ${formatBrl(info['valorTotal'])}}',
              ),
              isThreeLine: true,
            ),
          );
        },
      );

  Widget buildTotalizacaoVendasFaixaEtaria(
          Map<String, Map<String, dynamic>> dados) =>
      ListView.builder(
        itemCount: dados.length,
        itemBuilder: (context, index) {
          final faixaEtaria = dados.keys.elementAt(index);
          final info = dados[faixaEtaria];

          return Card.outlined(
            child: ListTile(
              title: Text(faixaEtaria),
              subtitle: Text(
                'Quantidade de Pedidos: ${info!['quantidade']} \nValor Total: ${formatBrl(info['valorTotal'])}',
              ),
            ),
          );
        },
      );
}
