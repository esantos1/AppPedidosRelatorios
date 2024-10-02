import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testetecnicosti3/models/item.dart';
import 'package:testetecnicosti3/models/pedido.dart';
import 'package:testetecnicosti3/utils/currency_format.dart';

class PedidosDetailsView extends StatelessWidget {
  const PedidosDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Pedido;

    return Scaffold(
      appBar: AppBar(title: Text('Pedido')),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _titleText(context, 'Dados do pedido'),
          SizedBox(height: 8),
          _atributeGroup(
            children: [
              _attributeDetailsItem(
                'Pedido feito em',
                DateFormat('dd/MM/yyyy - HH:mm', 'pt_BR')
                    .format(args.dataCriacao),
              ),
              _attributeDetailsItem('Número', args.numero.toString()),
              _attributeDetailsItem('ID', args.id),
              _attributeDetailsItem(
                'Cliente',
                args.cliente.nome ?? args.cliente.razaoSocial!,
              ),
              _attributeDetailsItem('Email', args.cliente.email),
            ],
          ),
          SizedBox(height: 32),
          _titleText(context, 'Produtos'),
          SizedBox(height: 8),
          _buildProductsList(args),
          SizedBox(height: 8),
          _atributeGroup(
            children: [
              _attributeDetailsItem('Subtotal', formatBrl(args.subTotal)),
            ],
          ),
          SizedBox(height: 32),
          _titleText(context, 'Endereço'),
          SizedBox(height: 8),
          Text(
            '${args.enderecoEntrega.endereco}, ${args.enderecoEntrega.numero}',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 12.0,
                ),
          ),
          SizedBox(height: 8),
          _atributeGroup(
            children: [
              _attributeDetailsItem('CEP', args.enderecoEntrega.cep),
              _attributeDetailsItem(
                'Bairro',
                args.enderecoEntrega.bairro ?? '-------',
              ),
              _attributeDetailsItem('Cidade', args.enderecoEntrega.cidade),
              _attributeDetailsItem('Bairro', args.enderecoEntrega.estado),
              _attributeDetailsItem(
                'Complemento',
                args.enderecoEntrega.complemento ?? '-',
              ),
              _attributeDetailsItem(
                'Referência',
                args.enderecoEntrega.referencia ?? '-',
              ),
            ],
          ),
        ],
      ),
    );
  }

  ListView _buildProductsList(Pedido args) => ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: args.itens.length,
        itemBuilder: (context, index) {
          final item = args.itens[index];

          return _buildItemsWidget(context, item);
        },
      );

  Widget _buildItemsWidget(BuildContext context, Item item) => Card.outlined(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: ListTile(
            title: Text(
              item.nome,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Text(
              formatBrl(item.valorUnitario),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontSize: 16.0),
            ),
          ),
        ),
      );

  Widget _titleText(BuildContext context, String title) => Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w700,
            ),
      );

  Table _atributeGroup({required List<TableRow> children}) => Table(
        columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
        children: children,
      );

  TableRow _attributeDetailsItem(String attributeName, String attributeValue) =>
      TableRow(
        children: [
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                attributeName,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(attributeValue),
            ),
          ),
        ],
      );
}
