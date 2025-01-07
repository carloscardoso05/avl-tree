import 'dart:math';

/// Retorna a profundidade de um nó, que pode ser nulo, se for nulo, retorna 0
int getNodeDepht(Node? node) {
  return node?.getDepth() ?? 0;
}

/// Retorna o fator de balanceamento de um nó, que pode ser nulo, se for nulo, retorna 0
int getNodeBalanceFactor(Node? node) {
  return node?.getBalanceFactor() ?? 0;
}

/// Nó de uma árvore binária
class Node<T extends num> {
  /// Valor do nó
  T value;

  /// Filho esquerdo
  Node<T>? left;

  /// Filho direito
  Node<T>? right;

  Node(this.value);

  /// Retorna a profundidade deste nó (sub árvore)
  int getDepth() => max(getNodeDepht(left), getNodeDepht(right)) + 1;

  /// Retorna o fator de balanceamento deste nó (sub árvore)
  int getBalanceFactor() => getNodeDepht(left) - getNodeDepht(right);

  /// Insere um valor nessa sub árvore e retorna o novo nó
  Node<T> insert(T newValue) {
    if (newValue.compareTo(value) <= 0) {
      if (left != null) return left!.insert(newValue);
      return left = Node(newValue);
    }
    // else
    if (right != null) return right!.insert(newValue);
    right = Node(newValue);
    return right!;
  }

  /// Procura um valor nessa sub árvore e retorna o nó correspondente se encontrar
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

  /// Remove o filho esquerdo, realiza as alterações necessárias na estrutura da árvore e retorna o nó removido
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

  /// Remove o filho direito, realiza as alterações necessárias na estrutura da árvore e retorna o nó removido
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

  /// Balanceia a sub árvore
  void balance() {
    final transformation = getTransformation();
    if (transformation != null) transformation();
    left?.balance();
    right?.balance();
  }

  /// Representação em texto dessa sub árvore
  @override
  String toString({
    int level = 0,
    bool? isLeft,
    bool printBF = false,
  }) {
    String str = '';
    if (right != null) {
      str +=
          right!.toString(level: (level + 1), isLeft: false, printBF: printBF);
    }
    str +=
        "${' ' * 4 * level}${isLeft == null ? '-' : isLeft ? '╰' : '╭'} $value${printBF ? '(${getBalanceFactor()})' : ''}\n";
    if (left != null) {
      str += left!.toString(level: (level + 1), isLeft: true, printBF: printBF);
    }
    return str;
  }

  /// Troca os filhos
  void switchChildren() {
    final temp = left;
    left = right;
    right = temp;
  }

  /// Realiza a rotação para a direita nessa sub árvore
  void rightRotation() {
    final oldRigth = right;
    right = left!.left;
    left!.left = oldRigth;
    left!.switchChildren();
    switchChildren();
    final oldValue = value;
    value = right!.value;
    right!.value = oldValue;
  }

  /// Realiza a rotação para a esquerda nessa sub árvore
  void leftRotation() {
    final oldLeft = left;
    left = right!.right;
    right!.right = oldLeft;
    right!.switchChildren();
    switchChildren();
    final oldValue = value;
    value = left!.value;
    left!.value = oldValue;
  }

  /// Realiza a rotação dupla para a direita nessa sub árvore
  void doubleRightRotation() {
    left!.leftRotation();
    rightRotation();
  }

  /// Realiza a rotação dupla para a esquerda nessa sub árvore
  void doubleLeftRotation() {
    right!.rightRotation();
    leftRotation();
  }

  /// Retorna a função de transformação necessária para balancear essa sub árvore, se estiver balanceada, retorna nulo
  void Function()? getTransformation() {
    final bf = getBalanceFactor();
    final leftBF = getNodeBalanceFactor(left);
    final rightBF = getNodeBalanceFactor(right);
    if (bf > 0 && leftBF > 0) {
      return rightRotation;
    }
    if (bf < 0 && rightBF < 0) {
      return leftRotation;
    }
    if (bf > 0 && leftBF < 0) {
      return doubleRightRotation;
    }
    if (bf < 0 && rightBF > 0) {
      return doubleLeftRotation;
    }
    return null;
  }
}
