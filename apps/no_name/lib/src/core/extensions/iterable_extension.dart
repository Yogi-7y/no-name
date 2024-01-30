extension IterableExtension<T> on Iterable<T> {
  Future<Iterable<R>> asyncMapIndexed<R>(
    Future<R> Function(int index, T element) f,
  ) async {
    final _list = <R>[];
    for (var i = 0; i < length; i++) {
      _list.add(await f(i, elementAt(i)));
    }
    return _list;
  }
}
