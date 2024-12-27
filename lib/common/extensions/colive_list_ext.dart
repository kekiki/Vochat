import 'dart:math';

extension ColiveListExt<E> on List<E> {
  List<E> randomList(int size) {
    if (length <= size) return this;
    List<E> allList = [];
    List<E> tempList = [];
    allList.addAll(this);
    for (int i = 0; i < size; i++) {
      final index = Random.secure().nextInt(allList.length);
      tempList.add(allList.removeAt(index));
    }
    return tempList;
  }
}
