// import 'package:elite_auction/core/API/CoreModels/base_result_model.dart';
// import 'package:elite_auction/core/API/CoreModels/empty_model.dart';
// import 'package:elite_auction/core/API/CoreModels/pagination_model.dart';
// import 'package:elite_auction/core/API/data_source/remote_data_source.dart';
// import 'package:elite_auction/core/API/http/api_urls.dart';
// import 'package:elite_auction/core/API/http/http_method.dart';
// import 'package:elite_auction/features/auctions/data/add_comment_request_model.dart';
//
// class CommentsRepository {
//   static Future<BaseResultModel> getComments(
//       {Pagination pagination, int productId}) async {
//     var response = await RemoteDataSource.request<Pagination>(
//       converter: (json) => Pagination.fromJson(json),
//       method: HttpMethod.GET,
//       withAuthentication: false,
//       queryParameters: {
//         "per_page": pagination.perPage,
//         "page": pagination.currentPage,
//       },
//       url: ApiURLs.getComments + '?product_id=$productId',
//     );
//
//     return response;
//   }
//
//   static Future<BaseResultModel> addComment(
//       CommentRequestModel commentRequestModel) async {
//     return await RemoteDataSource.request<EmptyModel>(
//         converter: (json) => EmptyModel.fromJson(json),
//         method: HttpMethod.POST,
//         data: commentRequestModel.toJson(),
//         withAuthentication: true,
//         url: ApiURLs.addCommentOnAuction);
//   }
// }
