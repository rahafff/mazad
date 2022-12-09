// import 'package:elite_auction/core/API/CoreModels/base_result_model.dart';
// import 'package:elite_auction/core/API/CoreModels/empty_model.dart';
// import 'package:elite_auction/core/API/data_source/remote_data_source.dart';
// import 'package:elite_auction/core/API/http/api_urls.dart';
// import 'package:elite_auction/core/API/http/http_method.dart';
// import 'package:elite_auction/features/auctions/data/bid_request_model.dart';
//
// class BidRepository {
//   static Future<BaseResultModel> bidOnAuction(
//       BidRequestModel BidRequestModel) async {
//     return await RemoteDataSource.request<EmptyModel>(
//         converter: (json) => EmptyModel.fromJson(json),
//         method: HttpMethod.POST,
//         data: BidRequestModel.toJson(),
//         withAuthentication: true,
//         url: ApiURLs.bidOnAuction);
//   }
// }
