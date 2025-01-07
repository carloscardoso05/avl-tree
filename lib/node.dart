part of 'avl_tree.dart';

int getNodeDepht(Node? node) {
  return node?.depth ?? 0;
}

class Node<T extends num> {
  T value;
  Node<T>? left;
  Node<T>? right;

  Node(this.value, {this.left, this.right});

  Node.fromValues(this.value, {T? left, T? right}) {
    if (left != null) this.left = Node(left);
    if (right != null) this.right = Node(right);
  }

  int get depth => max(getNodeDepht(left), getNodeDepht(right)) + 1;

  int get balanceFactor => getNodeDepht(left) - getNodeDepht(right);

  bool get isBalanced => balanceFactor >= -1 && balanceFactor <= 1;

  Node<T> insert(T newValue) {
    if (newValue.compareTo(value) <= 0) {
      if (left != null) return left!.insert(newValue);
      return left = Node(newValue);
    }
    // else
    if (right != null) return right!.insert(newValue);
    return right = Node(newValue);
  }

  Node<T>? search(T searchValue) {
    if (value.compareTo(searchValue) == 0) return this;
    if (value.compareTo(searchValue) < 0 && left != null) {
      return left!.search(searchValue);
    }
    if (value.compareTo(searchValue) > 0 && right != null) {
      return right!.search(searchValue);
    }
    return null;
  }

  Node<T>? deleteLeft() {
    if (left == null) return null;
    final Node<T> removed = left!;
    if (left!.left == null && left!.right == null) {
      left = null;
    } else if (left!.left == null && left!.right != null) {
      left = left!.right;
    } else if (left!.right == null && left!.left != null) {
      left = left!.left;
    } else {
      Node<T> parent = left!;
      Node<T> current = left!.right!;
      while (current.left != null) {
        parent = current;
        current = current.left!;
      }
      final Node<T> sucessor = parent.deleteLeft()!;
      left!.value = sucessor.value;
    }
    return removed;
  }

  Node<T>? deleteRight() {
    if (right == null) return null;
    final Node<T> removed = right!;
    if (right!.left == null && right!.right == null) {
      right = null;
    } else if (right!.left == null && right!.right != null) {
      right = right!.right;
    } else if (right!.right == null && right!.left != null) {
      right = right!.left;
    } else {
      Node<T> parent = right!;
      Node<T> current = right!.right!;
      while (current.left != null) {
        parent = current;
        current = current.left!;
      }
      final Node<T> sucessor = parent.deleteLeft()!;
      right!.value = sucessor.value;
    }
    return removed;
  }

  @override
  String toString([int level = 0, bool? isLeft]) {
    String str = '';
    if (level == 0) {
      str += 'Árvore AVL\n';
      str += '↑ Direita\n';
      str += '↓ Esquerda\n';
      str += '-----------\n';
    }
    if (right != null) str += right!.toString((level + 1), false);
    str +=
        "${' ' * 4 * level}${isLeft == null ? '-' : isLeft ? '╰' : '╭'} $value\n";
    if (left != null) str += left!.toString((level + 1), true);
    return str;
  }

  rightRotation() {}

  Function()? getTrasnformation() {
    if (getNodeDepht(left) > getNodeDepht(right) &&
        getNodeDepht(left?.left) > getNodeDepht(left?.right)) {
      return rightRotation;
    }
    return null;
  }
}
