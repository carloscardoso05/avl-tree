import 'package:trabalho_prog_2/search_binary_tree.dart';
import 'package:trabalho_prog_2/node.dart';

/// Árvore AVL
class AVLTree<T extends num> extends SearchBinaryTree<T> {
  /// Insere um valor na árvore, balanceia a árvore e retorna o novo nó
  @override
  Node<T> insert(T value) {
    final inserted = super.insert(value);
    balance();
    return inserted;
  }

  /// Remove um valor da árvore, balanceia a árvore e retorna o nó removido
  @override
  Node<T>? delete(T value) {
    final removed = super.delete(value);
    balance();
    return removed;
  }

  /// Balanceia a árvore
  void balance() => root?.balance();
}
