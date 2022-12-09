// import 'package:elite_auction/core/API/CoreModels/base_result_model.dart';
// import 'package:elite_auction/core/API/CoreModels/pagination_model.dart';
// import 'package:elite_auction/core/API/data_source/remote_data_source.dart';
// import 'package:elite_auction/core/API/http/api_urls.dart';
// import 'package:elite_auction/core/API/http/http_method.dart';
//
// class AuctionsRepository {
//   static Future<BaseResultModel> getAuctions(
//       {Pagination pagination, String auctionStatus}) async {
//     return await RemoteDataSource.request<Pagination>(
//       converter: (json) => Pagination.fromJson(json),
//       method: HttpMethod.GET,
//       url: ApiURLs.getAuctions,
//       withAuthentication: false,
//       queryParameters: {
//         "per_page": pagination.perPage,
//         "page": pagination.currentPage,
//         "auction_status": auctionStatus
//       },
//     );
//   }
//
//   static Future<BaseResultModel> getAuctionsWithEnrollments(
//       {Pagination pagination, String auctionStatue}) async {
//     return await RemoteDataSource.request<Pagination>(
//       converter: (json) => Pagination.fromJson(json),
//       method: HttpMethod.GET,
//       url: ApiURLs.getAuctionsWithEnrollments,
//       withAuthentication: true,
//       queryParameters: {
//         "per_page": pagination.perPage,
//         "page": pagination.currentPage,
//         "auction_status": auctionStatue
//       },
//     );
//   }
// }
