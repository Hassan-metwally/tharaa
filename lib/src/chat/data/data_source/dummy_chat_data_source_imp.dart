// import 'package:injectable/injectable.dart';
// import 'package:thoad/core/core.dart';
// import 'package:thoad/src/chat/data/models/api_chat_message_model.dart';
// import 'package:thoad/src/chat/domain/use_cases/get_chat_messages_use_case.dart';
// import '../../domain/use_cases/send_chat_message_use_case.dart';
// import '../models/api_message_author.dart';
// import 'chat_data_source.dart';

// @Injectable(as: ChatDataSource)
// class ChatDataSourceImp implements ChatDataSource {
//   ChatDataSourceImp();

//   ApiChatMessageModel _getDummyMessage(int index) {
//     return ApiChatMessageModel(
//       id: index,
//       isRead: true,
//       messageText: "Test Message $index",
//       type: index.isEven ? "owner" : '',
//       messageType: "",
//       createdAt: DateTime.now(),
//       author: ApiMessageAuthor(
//         id: index,
//         name: "User $index",
//         avatar: index.isEven
//             ? "https://images.unsplash.com/photo-1633332755192-727a05c4013d?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D"
//             : "https://wac-cdn.atlassian.com/dam/jcr:ba03a215-2f45-40f5-8540-b2015223c918/Max-R_Headshot%20(1).jpg?cdnVersion=2855",
//         type: index.isEven ? "student" : "teacher",
//       ),
//     );
//   }

//   @override
//   Future<ApiPaginatedData<ApiChatMessageModel>> getMessages(
//       GetChatMessagesParams params) async {
//     try {
//       await Future.delayed(const Duration(seconds: 5));
//       return ApiPaginatedData<ApiChatMessageModel>(
//           items: List.generate(
//             10,
//             (index) {
//               return _getDummyMessage(index);
//             },
//           ),
//           pageInfo: PageInfo(
//             currentPage: params.pageKey,
//             countPerPage: 10,
//             totalPages: 10,
//             lastPage: 10,
//             totalItemsCount: 50,
//           ));
//     } catch (e) {
//       rethrow;
//     }
//   }

//   @override
//   Future<ApiChatMessageModel> sendMessage(SendChatMessageParams params) async {
//     try {
//       await Future.delayed(const Duration(seconds: 5));
//       return _getDummyMessage(1);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   @override
//   Future<ApiChIChatDetailsEntityatInfoModel> getChatInformation(int id) async {
//     try {
//       await Future.delayed(const Duration(seconds: 5));
//       return ApiChatInfoModel(
//         currentUser: _getDummyMessage(1).author,
//         otherUser: _getDummyMessage(2).author,
//         id: 1,
//       );
//     } catch (e) {
//       rethrow;
//     }
//   }

//   @override
//   Future<void> setMessagesAsRead(int chatId) async {
//     try {
//       await Future.delayed(const Duration(seconds: 5));
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
