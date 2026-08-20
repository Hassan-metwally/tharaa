part of '/core/core.dart';

class ApiPaginatedData<T> extends PaginatedData<T> {
  const ApiPaginatedData.noDataFound() : super.noDataFound();

  const ApiPaginatedData({required super.items, required super.pageInfo});

  factory ApiPaginatedData.fromJson(Map<String, dynamic> json, {required List<T> Function(List<dynamic> dataList) getData}) {
    final Map<String, dynamic>? pageInfoMap = json["meta"];
    final PageInfo pageInfo = PageInfo(
      currentPage: pageInfoMap?["current_page"] ?? 0,
      countPerPage: pageInfoMap?["per_page"] ?? 0,
      lastPage: pageInfoMap?["last_page"] ?? 0,
      totalItemsCount: pageInfoMap?["total"] ?? 0,
      totalPages: pageInfoMap?["to"] ?? 0,
    );
    return ApiPaginatedData(pageInfo: pageInfo, items: getData(json["data"] ?? []));
  }
}

class PaginatedData<T> extends Equatable {
  final List<T> items;
  final PageInfo pageInfo;

  const PaginatedData({required this.items, required this.pageInfo});

  const PaginatedData.noDataFound() : this(items: const [], pageInfo: PageInfo.empty);

  PaginatedData<E> map<E>(E Function(T data) mapApiData) {
    return PaginatedData<E>(items: items.map<E>((item) => mapApiData(item)).toList(), pageInfo: pageInfo);
  }

  @override
  List<Object?> get props => [items, pageInfo];
}

class PageInfo extends Equatable {
  final int currentPage;
  final int lastPage;
  final int totalPages;
  final int countPerPage;
  final int totalItemsCount;

  const PageInfo({
    required this.currentPage,
    required this.countPerPage,
    required this.totalPages,
    required this.lastPage,
    required this.totalItemsCount,
  });

  static const PageInfo empty = PageInfo(currentPage: 0, lastPage: 0, countPerPage: 0, totalPages: 0, totalItemsCount: 0);

  bool get hasNext => !(currentPage >= lastPage);

  @override
  List<Object?> get props => [currentPage, lastPage, totalItemsCount];
}
