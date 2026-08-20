// ignore_for_file: constant_identifier_names
part of '/core/core.dart';

// const int _KFirstPageKey = 1;

// class MyPagingController<T> extends PagingController<int, T> {
//   MyPagingController()
//       : super(firstPageKey: _KFirstPageKey, invisibleItemsThreshold: 8);

//   List<T> onDataLoaded(PaginatedData<T>? data) {
//     try {
//       final isLastPage = !(data?.pageInfo.hasNext ?? false);
//       if (isLastPage) {
//         appendLastPage(data?.items as List<T>);
//         return itemList ?? <T>[];
//       } else {
//         final int nextPageKey = ((data?.pageInfo.currentPage ?? 0) + 1);
//         appendPage(data?.items as List<T>, nextPageKey);
//         return itemList ?? <T>[];
//       }
//     } catch (error) {
//       this.error = error;
//       return itemList ?? <T>[];
//     }
//   }

//   void updateItem(
//     bool Function(T e) updateWhere,
//     T newItem,
//   ) {
//     if (itemList == null) return;

//     final index = itemList!.firstIndexWhere(updateWhere);

//     if (index == null) {
//       debugPrint(
//           "====== [ MyPagingController (updateItem) ] ===================");
//       debugPrint("item Not found in Paginated List ");
//     } else {
//       final List<T> newList = List.from(itemList!);
//       newList[index] = newItem;
//       itemList = newList;
//     }
//     notifyListeners();
//   }

//   void removeWhere(bool Function(T e) where) {
//     if (itemList == null) return;
//     final index = itemList!.firstIndexWhere(where);
//     if (index != null && index != -1) {
//       final List<T> newList = [...itemList ?? <T>[]];
//       if (newList.isNotEmpty) {
//         newList.removeAt(index);
//         itemList?.clear();
//         itemList?.addAll(newList);
//       }
//     } else {
//       debugPrint(
//           "====== [ MyPagingController (removeWhere) ] ===================");
//       debugPrint("item Not found in Paginated List ");
//     }
//     notifyListeners();
//   }

//   T? getItemAtIndex(int index) {
//     try {
//       if (index >= 0) {
//         return itemList?[index];
//       } else {
//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   T? getItem(bool Function(T e) where) {
//     if (itemList == null || itemList?.isEmpty == true) return null;
//     return itemList!.firstWhereOrNull(where);
//   }

//   void addNew(T item) {
//     final List<T> newList = List.from(itemList ?? <T>[]);
//     newList.insert(0, item);
//     itemList?.clear();
//     itemList?.addAll(newList);
//     notifyListeners();
//   }

//   void addNewIfNotExist(T item, bool Function(T e) existWhere) {
//     final T? existItem = itemList?.firstWhereOrNull(existWhere);
//     if (existItem == null) {
//       final List<T> newList = List.from(itemList ?? <T>[]);
//       newList.insert(0, item);
//       itemList?.clear();
//       itemList?.addAll(newList);
//       notifyListeners();
//     }
//   }

//   void mapItems(T Function(T item) map) {
//     List<T> tempItemsList = List.from(itemList ?? <T>[]);
//     tempItemsList = tempItemsList.map(map).toList();
//     itemList?.clear();
//     itemList?.addAll(tempItemsList);
//     notifyListeners();
//   }

//   void clear() {
//     itemList?.clear();
//     nextPageKey = _KFirstPageKey;
//     notifyListeners();
//   }

//   T? get getLastItem => itemList?.lastOrNull;

//   PagingStatus get pagingStatus => super.value.status;
// }
