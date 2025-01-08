import 'package:trabalho_prog_2/avl_tree.dart';

void main() {
  // Instancia a árvore
  final avlTree = AVLTree();

  final values = [6, 11, 7, 25, 0, 14, 19, 26, 8, 26, 24, 19, 11, 10, 25];

  // Insere os valores iniciais na árvore
  avlTree.insertAll(values);

  // Remove alguns valores
  final deleteValues = [19, 26, 7];
  avlTree.deleteAll(deleteValues);

  // Insere alguns novos valores
  final newValues = [20, 13, 2, 9];
  avlTree.insertAll(newValues);

  avlTree.printTree(showBF: true);
  // Caso queira visualizar os fatores de balanceamento, use "avlTree.printTree(showBF: true)"
}
