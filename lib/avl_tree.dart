import 'dart:math';

part 'node.dart';

class AVLTree<T extends num> {
  Node<T>? root;

  Node<T> insert(T value) {
    if (root == null) return root = Node(value);
    return root!.insert(value);
  }

  Node<T>? search(T value) {
    if (root == null) return null;
    return root!.search(value);
  }

  Node<T>? delete(T value) {
    if (root == null) return null;
    if (root!.value == value) return root;
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
    if (parent.left?.value == value) return parent.deleteLeft();
    if (parent.right?.value == value) return parent.deleteRight();
    return null;
  }

  @override
  String toString([int depth = 0]) {
    if (root == null) return 'Árvore vazia';
    return root!.toString();
  }
}
