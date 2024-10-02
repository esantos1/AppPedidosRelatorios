# AppPedidosRelatorios

## Funcionalidades

- Listagem de Pedidos: Exibe uma lista de pedidos realizados com detalhes.

- Relatórios de Vendas: Possibilidade de visualizar relatórios de vendas por:

  - Produtos mais vendidos;

  - Totalização por formas de pagamento;

  - Totalização de vendas por cidade;

  - Totalização de vendas por faixa etária.

- Navegação via Drawer: Menu lateral para alternar entre diferentes telas do aplicativo.

- Armazenamento com Hive: Persistência de dados local com Hive para o gerenciamento dos pedidos.

## Como Rodar o Projeto

1. Clone o repositório:

```bash
git clone https://github.com/seu-usuario/AppPedidosRelatorios.git
```

2. Navegue até o diretório do projeto:

```bash
cd AppPedidosRelatorios
```

3. Instale as dependências:

```bash
flutter pub get
```

4. Execute o aplicativo:

```bash
flutter run
```

## Como o Projeto Foi Desenvolvido

O projeto foi desenvolvido seguindo as boas práticas de Flutter, com separação de responsabilidades, uso de ChangeNotifier para gerenciamento de estado, armazenamento de dados usando o Hive e implementação de layouts adaptáveis para exibir os dados de maneira clara e organizada.

## Estrutura de Relatórios

- Produtos Mais Vendidos: Exibe os produtos mais vendidos, ordenados do maior para o menor.

- Totalização por Formas de Pagamento: Exibe a totalização de vendas por forma de pagamento, ordenando os resultados da data mais recente para a mais antiga.

- Totalização de Vendas por Cidade: Exibe a quantidade de pedidos e o valor total por cidade.

- Totalização de Vendas por Faixa Etária: Classifica as vendas de acordo com a faixa etária do cliente.

## Autor

Desenvolvido por [Erick Santos](https://ericksantos.com.br).
