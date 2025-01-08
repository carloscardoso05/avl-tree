import 'package:trabalho_prog_2/node.dart';

/// Árvore AVL
class AVLTree {
  /// Nó raiz
  Node? root;

  /// Insere um valor na árvore
  void insert(int key) {
    root = insertKey(root, key);
  }

  /// Remove um valor da árvore
  void delete(int key) {
    root = deleteKey(root, key);
  }

  /// Insere vários valores na árvore
  void insertAll(Iterable<int> keys) {
    keys.forEach(insert);
  }

  /// Remove vários valores da árvore
  void deleteAll(Iterable<int> keys) {
    keys.forEach(delete);
  }

  /// Representação em texto da árvore
  @override
  String toString({bool showBF = false}) {
    if (root == null) return 'Árvore vazia';
    String header = '-----------' * 5;
    header += '\nÁrvore AVL\n';
    header += '↑ Direita\n';
    header += '↓ Esquerda\n';
    return header + root!.toString(showBF: showBF);
  }

  /// Imprime a árvore 
  void printTree({bool showBF = false}) {
    print(toString(showBF: showBF));
  }
}
