class Pagination {
  Pagination({
    required this.total,
    required this.lastPage,
    required this.perPage,
    required this.currentPage,
  });

  final int total;
  final int lastPage;
  final int perPage;
  int currentPage;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    lastPage: json["last_page"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
  );
}
