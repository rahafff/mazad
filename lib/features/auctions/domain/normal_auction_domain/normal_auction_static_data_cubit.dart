// import 'package:bloc/bloc.dart';
// import 'package:elite_auction/core/API/CoreModels/base_response_model.dart';
// import 'package:elite_auction/core/API/errors/base_error.dart';
// import 'package:elite_auction/features/auctions/data/normal_auction_static_data.dart';
// import 'package:elite_auction/features/auctions/domain/normal_auction_domain/normal_auction_repo/norma_auction_repo.dart';
// import 'package:meta/meta.dart';
//
// part 'normal_auction_static_data_state.dart';
//
// class NormalAuctionStaticDataCubit extends Cubit<NormalAuctionStaticDataState> {
//   NormalAuctionStaticDataCubit() : super(NormalAuctionStaticDataInitial());
//
//   Future<void> getAuctionStaticData({@required int auctionId}) async {
//     emit(NormalAuctionStaticDataLoading());
//     var response = await NormalAuctionRepository.getNormalAuctionStaticData(
//         auctionId: auctionId);
//     if (response is NormalAuctionStaticDataResponseModel) {
//       emit(NormalAuctionStaticDataSuccess(auction: response));
//     } else if (response is BaseError) {
//       emit(NormalAuctionStaticDataError(message: response.message));
//     } else if (response is Message) {
//       emit(NormalAuctionStaticDataError(message: response.content));
//     }
//   }
// }
