// import 'package:elite_auction/core/API/CoreModels/base_result_model.dart';
// import 'package:elite_auction/core/API/data_source/remote_data_source.dart';
// import 'package:elite_auction/core/API/http/api_urls.dart';
// import 'package:elite_auction/core/API/http/http_method.dart';
// import 'package:elite_auction/features/auctions/data/auction.dart';
// import 'package:elite_auction/features/auctions/data/normal_auction_static_data.dart';
//
// class NormalAuctionRepository {
//   static Future<BaseResultModel> getNormalAuctionStaticData(
//       {int auctionId}) async {
//     var response =
//         await RemoteDataSource.request<NormalAuctionStaticDataResponseModel>(
//       converter: (json) => NormalAuctionStaticDataResponseModel.fromJson(json),
//       method: HttpMethod.GET,
//       withAuthentication: false,
//       url: ApiURLs.getNormalAuctionStaticData + '?auction_id=$auctionId',
//     );
//     return response;
//   }
// }
