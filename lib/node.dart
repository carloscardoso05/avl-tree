import 'dart:math';

/// Nó da árvore
class Node {
  /// Chave do nó
  int key;

  /// Filho esquerdo
  Node? left;

  /// Filho direito
  Node? right;

  /// Altura do nó. Por padrão é igual a 1
  int height = 1;

  /// Representação textual do nó (sub árvore)
  @override
  String toString({
    int level = 0,
    bool? isLeft,
    bool showBF = false,
  }) {
    String str = '';
    if (right != null) {
      str += right!.toString(level: (level + 1), isLeft: false, showBF: showBF);
    }
    str +=
        "${' ' * 4 * level}${isLeft == null ? '→' : isLeft ? '╰' : '╭'} $key${showBF ? '(${getBalanceFactor(this)})' : ''}\n";
    if (left != null) {
      str += left!.toString(level: (level + 1), isLeft: true, showBF: showBF);
    }
    return str;
  }

  Node(this.key);
}

/// Retorna a altura de um nó se ele existir, senão, retorna 0
int height(Node? node) {
  return node?.height ?? 0;
}

/// Retorna o fator de balanceamento de um nó se ele existir, senão, retorna 0
int getBalanceFactor(Node? node) {
  if (node == null) return 0;
  return height(node.left) - height(node.right);
}

/// Atualiza a altura de um nó
void updateHeight(Node? node) {
  if (node != null) {
    node.height = 1 + max(height(node.left), height(node.right));
  }
}

/// Busca o nó com menor chave em uma sub árvore
Node? minValueNode(Node? root) {
  Node? current = root;
  while (current?.left != null) {
    current = current?.left;
  }
  return current;
}

/// Realiza a rotação para a direita em um nó
/// ```
///     p            u  
///    / \          / \ 
///   u   T3   ->  T1  p
///  / \              / \   
/// T1 T2            T2 T3
/// ```
Node? rotateRight(Node? p) {
  final Node? u = p?.left;
  final Node? t2 = u?.right;
  u?.right = p;
  p?.left = t2;
  updateHeight(p);
  updateHeight(u);
  return u; // Nova raiz da sub árvore
}

/// Realiza a rotação para a direita em um nó
/// ```
///   p            u  
///  / \          / \ 
/// T1  u   ->   p  T3
///    / \      / \   
///   T2 T3    T1 T2
/// ```
Node? rotateLeft(Node? p) {
  var y = p?.right;
  var z = y?.left;
  y?.left = p;
  p?.right = z;
  updateHeight(p);
  updateHeight(y);
  return y; // Nova raiz da sub árvore
}

/// Balanceia uma sub árvore se necessário
Node? balance(Node? root) {
  if (root == null) return null;

  updateHeight(root);

  final balance = getBalanceFactor(root);

  if (balance > 1 && getBalanceFactor(root.left) >= 0) {
    return rotateRight(root);
  }
  if (balance < -1 && getBalanceFactor(root.right) <= 0) {
    return rotateLeft(root);
  }
  if (balance > 1 && getBalanceFactor(root.left) < 0) {
    root.left = rotateLeft(root.left);
    return rotateRight(root);
  }
  if (balance < -1 && getBalanceFactor(root.right) > 0) {
    root.right = rotateRight(root.right);
    return rotateLeft(root);
  }

  return root;
}

/// Insere uma chave na sub árvore
Node? insertKey(Node? node, int key) {
  if (node == null) {
    return Node(key);
  }

  if (key <= node.key) {
    node.left = insertKey(node.left, key);
  } else {
    node.right = insertKey(node.right, key);
  }

  return balance(node);
}

/// Remove uma chave da sub árvore
Node? deleteKey(Node? root, int key) {
  if (root == null) {
    return root;
  }

  if (key < root.key) {
    root.left = deleteKey(root.left, key);
  } else if (key > root.key) {
    root.right = deleteKey(root.right, key);
  } else {
    if (root.left == null) {
      return root.right;
    } else if (root.right == null) {
      return root.left;
    }

    var temp = minValueNode(root.right);
    root.key = temp!.key;
    root.right = deleteKey(root.right, temp.key);
  }

  return balance(root);
}
