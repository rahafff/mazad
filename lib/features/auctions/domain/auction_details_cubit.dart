// import 'package:bloc/bloc.dart';
// import 'package:elite_auction/core/API/CoreModels/base_response_model.dart';
// import 'package:elite_auction/core/API/CoreModels/empty_model.dart';
// import 'package:elite_auction/core/API/errors/base_error.dart';
// import 'package:elite_auction/features/auctions/data/auction.dart';
// import 'package:elite_auction/features/auctions/domain/repo/auction_repo.dart';
// import 'package:meta/meta.dart';
// import 'package:easy_localization/easy_localization.dart';
// part 'auction_details_state.dart';
//
// class AuctionDetailsCubit extends Cubit<AuctionDetailsState> {
//   AuctionDetailsCubit() : super(AuctionInitial());
//   bool isEnrolled;
//   Future<void> getAuction(
//       {@required int auctionId, bool withEnrollment = false}) async {
//     emit(AuctionDetailsLoading());
//     var response = withEnrollment
//         ? await AuctionRepository.getAuctionWithEnrollment(auctionId: auctionId)
//         : await AuctionRepository.getAuction(auctionId: auctionId);
//     if (response is AuctionDetailsResponseModel) {
//       isEnrolled = response.isEnrolled;
//       emit(AuctionDetailsSuccess(auction: response));
//     } else if (response is BaseError) {
//       emit(AuctionDetailsError(message: response.message));
//     } else if (response is Message) {
//       emit(AuctionDetailsError(message: response.content));
//     }
//   }
//
//   Future<void> enrollInAuction({@required int auctionId}) async {
//     emit(EnrollInAuctionLoading());
//     var response =
//         await AuctionRepository.enrollInAuction(auctionId: auctionId);
//     if (response is EmptyModel) {
//       emit(EnrollInAuctionSuccess(
//           message: 'You have successfully enrolled in this auction'.tr()));
//     } else if (response is BaseError) {
//       emit(EnrollInAuctionError(message: response.message));
//     } else if (response is Message) {
//       emit(EnrollInAuctionError(message: response.content));
//     }
//     getAuction(auctionId: auctionId, withEnrollment: true);
//   }
// }
