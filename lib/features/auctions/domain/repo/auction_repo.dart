// import 'package:elite_auction/core/API/CoreModels/base_result_model.dart';
// import 'package:elite_auction/core/API/CoreModels/empty_model.dart';
// import 'package:elite_auction/core/API/data_source/remote_data_source.dart';
// import 'package:elite_auction/core/API/http/api_urls.dart';
// import 'package:elite_auction/core/API/http/http_method.dart';
// import 'package:elite_auction/features/auctions/data/auction.dart';
//
// class AuctionRepository {
//   static Future<BaseResultModel> getAuction({int auctionId}) async {
//     var response = await RemoteDataSource.request<AuctionDetailsResponseModel>(
//       converter: (json) => AuctionDetailsResponseModel.fromJson(json),
//       method: HttpMethod.GET,
//       withAuthentication: false,
//       url: ApiURLs.getAuctionDetails + '?auction_id=$auctionId',
//     );
//     return response;
//   }
//
//   static Future<BaseResultModel> enrollInAuction({int auctionId}) async {
//     var response = await RemoteDataSource.request<EmptyModel>(
//       converter: (json) => EmptyModel.fromJson(json),
//       data: {"auction_id": auctionId},
//       method: HttpMethod.POST,
//       withAuthentication: false,
//       url: ApiURLs.enrollInAuction,
//     );
//     return response;
//   }
//
//   static Future<BaseResultModel> getAuctionWithEnrollment(
//       {int auctionId}) async {
//     var response = await RemoteDataSource.request<AuctionDetailsResponseModel>(
//       converter: (json) => AuctionDetailsResponseModel.fromJson(json),
//       method: HttpMethod.GET,
//       withAuthentication: true,
//       url: ApiURLs.getAuctionWithEnrollmentDetails + '?auction_id=$auctionId',
//     );
//     return response;
//   }
// }
