import 'package:flutter/material.dart';
import 'package:testetecnicosti3/models/pedido.dart';
import 'package:testetecnicosti3/utils/currency_format.dart';

class ParcelasView extends StatelessWidget {
  final Pedido pedido;
  const ParcelasView({super.key, required this.pedido});

  final _tableHeaderRowTextColor = Colors.white;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _tabelaProdutos(context, pedido),
            SizedBox(height: 8.0),
            _tabelaPagamento(context, pedido),
            SizedBox(height: 8.0),
            Card.outlined(
              child: ListTile(
                title: Text(
                  'Subtotal',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                subtitle: Text(formatBrl(pedido.subTotal)),
              ),
            ),
            SizedBox(height: 8.0),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: Navigator.of(context).pop,
                child: Text('Fechar'),
              ),
            ),
          ],
        ),
      );

  TableRow _tableHeaderRow(
    BuildContext context, {
    required List<TableCell> items,
  }) =>
      TableRow(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        children: items,
      );

  Widget _tabelaProdutos(BuildContext context, Pedido item) => Table(
        border: TableBorder.all(),
        children: [
          _tableHeaderRow(context, items: [
            _tableCell('Produto', textColor: _tableHeaderRowTextColor),
            _tableCell('Quantidade', textColor: _tableHeaderRowTextColor),
            _tableCell('Valor Unitário', textColor: _tableHeaderRowTextColor),
          ]),
          ...item.itens.map((e) {
            return TableRow(
              children: [
                _tableCell(e.nome),
                _tableCell(e.quantidade.toString()),
                _tableCell(formatBrl(e.valorUnitario)),
              ],
            );
          }),
        ],
      );

  Widget _tabelaPagamento(BuildContext context, Pedido item) => Table(
        border: TableBorder.all(),
        children: [
          _tableHeaderRow(context, items: [
            _tableCell('Pagamento', textColor: _tableHeaderRowTextColor),
            _tableCell('Parcela', textColor: _tableHeaderRowTextColor),
            _tableCell('Valor', textColor: _tableHeaderRowTextColor)
          ]),
          ...item.pagamento.map((e) => TableRow(
                children: [
                  _tableCell(e.nome),
                  _tableCell(e.parcela.toString()),
                  _tableCell(formatBrl(e.valor)),
                ],
              )),
        ],
      );

  TableCell _tableCell(String text, {Color? textColor}) => TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      );
}
