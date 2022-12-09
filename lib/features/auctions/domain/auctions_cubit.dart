// import 'package:bloc/bloc.dart';
// import 'package:elite_auction/core/API/CoreModels/base_response_model.dart';
// import 'package:elite_auction/core/API/CoreModels/pagination_model.dart';
// import 'package:elite_auction/core/API/errors/base_error.dart';
// import 'package:elite_auction/features/auctions/data/auction.dart';
// import 'package:elite_auction/features/auctions/domain/repo/auctions_repo.dart';
// import 'package:meta/meta.dart';
//
// part 'auctions_state.dart';
//
// class AuctionsCubit extends Cubit<AuctionsState> {
//   AuctionsCubit() : super(AuctionsInitial());
//
//   List<dynamic> auctions = [];
//   int auctionsCurrentPage = 1;
//   int lastPageForAuctions;
//
//   Future<void> getAuctions(
//       {int perPage = 8,
//       bool loadMore = false,
//       bool isRefreshing = false,
//       bool withEnrollment = false,
//       String auctionStatus}) async {
//     if (isRefreshing) {
//       auctionsCurrentPage = 1;
//     }
//     if (loadMore) {
//       if (lastPageForAuctions != auctionsCurrentPage)
//         auctionsCurrentPage++;
//       else
//         return;
//     } else {
//       auctionsCurrentPage = 1;
//       emit(AuctionsLoading());
//     }
//     var requestData = Pagination(
//         currentPage: auctionsCurrentPage, perPage: perPage.toString());
//
//     var response = withEnrollment
//         ? await AuctionsRepository.getAuctionsWithEnrollments(
//             pagination: requestData, auctionStatue: auctionStatus)
//         : await AuctionsRepository.getAuctions(
//             pagination: requestData,
//             auctionStatus: auctionStatus,
//           );
//
//     if (response is Pagination) {
//       lastPageForAuctions = response.lastPage;
//       List<dynamic> auctionsAsList = <dynamic>[];
//       auctionsAsList = (response.data)
//           .map((auction) => AuctionDetailsResponseModel.fromJson(auction))
//           .toList();
//       if (loadMore)
//         this.auctions.addAll(auctionsAsList);
//       else
//         this.auctions = auctionsAsList;
//
//       emit(AuctionsSuccess(
//           auctions: this.auctions, currentPage: response.currentPage));
//     } else if (response is BaseError) {
//       if (auctionsCurrentPage > 1) auctionsCurrentPage--;
//       emit(AuctionsError(message: response.message));
//     } else if (response is Message) {
//       emit(AuctionsError(message: response.content));
//     }
//   }
// }
