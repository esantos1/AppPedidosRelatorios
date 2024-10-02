import 'package:flutter/material.dart';
import 'package:testetecnicosti3/views/pedidos_view.dart';
import 'package:testetecnicosti3/views/relatorios_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int index = 0;
  final _menuItems = [
    _MenuItem(
      icon: Icons.shopping_bag,
      title: 'Pedidos',
      page: PedidosView(),
    ),
    _MenuItem(
      icon: Icons.insert_chart,
      title: 'Relatórios',
      page: RelatoriosView(),
    ),
  ];
  late String title;

  @override
  void initState() {
    super.initState();

    title = _menuItems.first.title;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: IndexedStack(
          index: index,
          children: _menuItems.map((item) => item.page).toList(),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Center(
                  child: Text(
                    'Olá, seja bem vindo!',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
              ..._menuItems.map(
                (item) => ListTile(
                  leading: Icon(item.icon),
                  title: Text(item.title),
                  selected: index == _menuItems.indexOf(item),
                  selectedColor: Theme.of(context).primaryColor,
                  selectedTileColor: Colors.grey[300],
                  onTap: () => setIndexValue(
                    _menuItems.indexOf(item),
                    item.title,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void setIndexValue(int newIndex, String newTitle) {
    setState(() {
      index = newIndex;
      title = newTitle;
    });

    Navigator.pop(context);
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final Widget page;

  _MenuItem({required this.icon, required this.title, required this.page});
}
