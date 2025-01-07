import 'package:trabalho_prog_2/avl_tree.dart';

void main() {
  var tree = AVLTree<int>();
  [7, 13, 20, 4, 1, 18, 5, 11].forEach(tree.insert);
  print(tree);
  tree.delete(13);
  print(tree);

  tree = AVLTree();
  [15, 5, 16, 3, 12, 20, 10, 13, 18, 23, 6, 7].forEach(tree.insert);
  print(tree);
  tree.delete(5);
  print(tree);
}
