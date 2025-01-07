import 'package:trabalho_prog_2/node.dart';

/// Árvore Binária de Busca
class SearchBinaryTree<T extends num> {
  /// Nó raiz da árvore
  Node<T>? root;

  /// Limpa a árvore
  void clear() {
    root = null;
  }

  /// Insere todos os valores na árvore
  void insertAll(Iterable<T> values) {
    values.forEach(insert);
  }

  /// Remove todos os valores especificados da árvore
  void deleteAll(Iterable<T> values) {
    values.forEach(delete);
  }

  /// Insere um valor na árvore e retorna o nó adicionado
  Node<T> insert(T value) {
    if (root == null) return root = Node(value);
    final inserted = root!.insert(value);
    return inserted;
  }

  /// Procura um valor na árvore e retorna o nó correspondente se houver
  Node<T>? search(T value) {
    if (root == null) return null;
    return root!.search(value);
  }

  /// Remove um valor da árvore e retorna o nó removido se houver
  Node<T>? delete(T value) {
    if (root == null) return null;
    if (root!.value == value) {
      final removed = root;
      root = null;
      return removed;
    }
    Node<T> parent = root!;
    while (![parent.left?.value, parent.right?.value].contains(value)) {
      if (value < parent.value && parent.left != null) {
        parent = parent.left!;
        continue;
      }
      if (value > parent.value && parent.right != null) {
        parent = parent.right!;
        continue;
      }
      return null;
    }
    Node<T>? removed;
    if (parent.left?.value == value) {
      removed = parent.deleteLeft();
    } else if (parent.right?.value == value) {
      removed = parent.deleteRight();
    }
    return removed;
  }

  /// Representação em texto da árvore
  @override
  String toString({bool showBF = false}) {
    if (root == null) return 'Árvore vazia';
    return root!.toString(printBF: showBF);
  }

  /// Imprime a árvore
  void printTree({bool showBF = false}) {
    print(toString(showBF: showBF));
  }
}
