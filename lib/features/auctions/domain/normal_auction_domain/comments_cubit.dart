// import 'package:bloc/bloc.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:elite_auction/core/API/CoreModels/base_response_model.dart';
// import 'package:elite_auction/core/API/CoreModels/empty_model.dart';
// import 'package:elite_auction/core/API/CoreModels/pagination_model.dart';
// import 'package:elite_auction/core/API/errors/base_error.dart';
// import 'package:elite_auction/features/auctions/data/add_comment_request_model.dart';
// import 'package:elite_auction/features/auctions/domain/normal_auction_domain/normal_auction_repo/comments_repo.dart';
// import 'package:meta/meta.dart';
//
// part 'comments_state.dart';
//
// class CommentsCubit extends Cubit<CommentsState> {
//   CommentsCubit() : super(CommentsInitial());
//
//   List<dynamic> comments = [];
//   int commentsCurrentPage = 1;
//   int lastPageForComments;
//   //
//   // Future<void> getComments(
//   //     {int perPage = 5, bool loadMore = false, @required int productId}) async {
//   //   if (loadMore) {
//   //     if (lastPageForComments != commentsCurrentPage)
//   //       commentsCurrentPage++;
//   //     else
//   //       return;
//   //   } else {
//   //     commentsCurrentPage = 1;
//   //     emit(GetCommentsLoading());
//   //   }
//   //   var requestData = Pagination(
//   //       currentPage: commentsCurrentPage, perPage: perPage.toString());
//   //
//   //   var response = await CommentsRepository.getComments(
//   //       pagination: requestData, productId: productId);
//   //
//   //   if (response is Pagination) {
//   //     lastPageForComments = response.lastPage;
//   //     List<dynamic> commentsAsList = <dynamic>[];
//   //     commentsAsList = (response.data)
//   //         .map((comment) => CommentResponseModel.fromJson(comment))
//   //         .toList();
//   //     if (loadMore)
//   //       this.comments.addAll(commentsAsList);
//   //     else
//   //       this.comments = commentsAsList;
//   //
//   //     emit(GetCommentsSuccessful(
//   //         comments: this.comments, currentPage: response.currentPage));
//   //   } else if (response is BaseError) {
//   //     if (commentsCurrentPage > 1) commentsCurrentPage--;
//   //     emit(GetCommentsError(message: response.message));
//   //   } else if (response is Message) {
//   //     emit(GetCommentsError(message: response.content));
//   //   }
//   // }
//
//   Future<void> addComment({CommentRequestModel commentRequestModel}) async {
//     emit(AddCommentLoading());
//
//     var response = await CommentsRepository.addComment(commentRequestModel);
//     if (response is EmptyModel) {
//       emit(AddCommentSuccessful(
//           message: 'Your comment has been added successfully'.tr()));
//     } else if (response is BaseError) {
//       print(response.message);
//       emit(AddCommentError(message: response.message));
//     } else if (response is Message) {
//       emit(AddCommentError(message: response.content));
//     }
//   }
// }
