import 'package:trabalho_prog_2/avl_tree.dart';
import 'package:trabalho_prog_2/search_binary_tree.dart';

/// Imprime o cabeçalho da árvore
void printTreeHeader(String title) {
  String header = '-----------' * 5;
  header += '\n$title\n';
  header += '↑ Direita\n';
  header += '↓ Esquerda\n';
  print(header);
}

void main() {
  // Instancia as árvores
  final avlTree = AVLTree<int>();
  final binaryTree = SearchBinaryTree<int>();

  final values = [6, 11, 7, 25, 0, 14, 19, 26, 8, 26, 24, 19, 11, 10, 25];

  // Insere os valores iniciais nas árvores
  binaryTree.insertAll(values);
  avlTree.insertAll(values);

  // Remove alguns valores
  final deleteValues = [19, 26, 7];
  binaryTree.deleteAll(deleteValues);
  avlTree.deleteAll(deleteValues);

  // Insere alguns novos valores
  final newValues = [20, 13, 2, 9];
  binaryTree.insertAll(newValues);
  avlTree.insertAll(newValues);

  // Compara a organização da árvore binária não balanceada com a árvore AVL balanceada
  printTreeHeader('Árvore Binária');
  binaryTree.printTree();
  printTreeHeader('Árvore AVL');
  avlTree.printTree();
  // Caso queira visualizar os fatores de balanceamento, use "avlTree.printTree(showBF: true)"
}
