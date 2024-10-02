import 'package:flutter/material.dart';
import 'package:testetecnicosti3/models/pedido.dart';
import 'package:testetecnicosti3/store/pedidos_store.dart';
import 'package:testetecnicosti3/views/parcelas_view.dart';

class PedidosView extends StatefulWidget {
  const PedidosView({super.key});

  @override
  State<PedidosView> createState() => _PedidosViewState();
}

class _PedidosViewState extends State<PedidosView> {
  final store = PedidosStore();
  final pedidosSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    store.carregarPedidos();
  }

  @override
  void dispose() {
    store.dispose();
    pedidosSearchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: store,
        builder: (context, child) {
          if (store.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (store.pedidos.isEmpty && !store.haveBoxData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Nenhum pedido encontrado.'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: store.consultarPedidos,
                    child: Text('Sincronizar com a API'),
                  ),
                ],
              ),
            );
          }

          if (store.error.isNotEmpty) {
            Center(
              child: Column(
                children: [
                  Text(store.error),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (store.haveBoxData) {
                        store.carregarPedidos();
                      } else {
                        store.consultarPedidos();
                      }
                    },
                    child: Text('Tentar novamente'),
                  )
                ],
              ),
            );
          }

          if (store.pedidos.isEmpty && store.haveBoxData) {
            return Center(
              child: ElevatedButton(
                onPressed: store.carregarPedidos,
                child: Text('Buscar Pedidos Salvos'),
              ),
            );
          }

          return _onSearchedWidgetPage();
        },
      );

  Widget _onSearchedWidgetPage() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: pedidosSearchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Pesquisar',
                      prefixIcon: Icon(Icons.search, size: 30.0),
                      suffixIcon: IconButton(
                        onPressed: _clearSearchBar,
                        icon: Icon(Icons.close, size: 30.0),
                      ),
                    ),
                    onChanged: store.filterPedidos,
                  ),
                ),
                IconButton(
                  onPressed: store.consultarPedidos,
                  icon: Icon(Icons.sync),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: store.filteredPedidos.length,
                itemBuilder: (context, index) {
                  final item = store.filteredPedidos[index];

                  return _buildPedidoWidget(item, context);
                },
              ),
            ),
          ],
        ),
      );

  Widget _buildPedidoWidget(Pedido item, BuildContext context) => ListTile(
        title: Text(item.cliente.nome ?? item.cliente.razaoSocial!),
        subtitle: Text(item.enderecoEntrega.endereco),
        onTap: () => Navigator.pushNamed(
          context,
          '/pedidos-details',
          arguments: item,
        ),
        trailing: IconButton(
          onPressed: () => _mostrarDetalhes(item),
          icon: Icon(Icons.info),
        ),
      );

  void _clearSearchBar() {
    if (pedidosSearchController.text.isNotEmpty) {
      pedidosSearchController.clear();

      store.filterPedidos('');
    }
  }

  void _mostrarDetalhes(Pedido item) => showDialog(
        context: context,
        builder: (context) => Dialog.fullscreen(
          child: ParcelasView(pedido: item),
        ),
      );
}
