class Page<T> {
  final int currentPage;
  final bool isLastPage;
  final List<T> data;

  Page(
      {required this.currentPage,
      required this.isLastPage,
      required this.data});
}
