// import 'package:bloc/bloc.dart';
// import 'package:elite_auction/core/API/CoreModels/base_response_model.dart';
// import 'package:elite_auction/core/API/CoreModels/empty_model.dart';
// import 'package:elite_auction/core/API/errors/base_error.dart';
// import 'package:elite_auction/features/auctions/data/bid_request_model.dart';
// import 'package:elite_auction/features/auctions/domain/normal_auction_domain/normal_auction_repo/bid_repo.dart';
// import 'package:meta/meta.dart';
// import 'package:easy_localization/easy_localization.dart';
// part 'bid_state.dart';
//
// class BidCubit extends Cubit<BidState> {
//   BidCubit() : super(BidInitial());
//   Future<void> bidOnAuction({BidRequestModel bidRequestModel}) async {
//     emit(BidLoading());
//
//     var response = await BidRepository.bidOnAuction(bidRequestModel);
//     if (response is EmptyModel) {
//       emit(
//           BidSuccess(message: 'Your bid has been Submitted successfully'.tr()));
//     } else if (response is BaseError) {
//       print(response.message);
//       emit(BidError(message: response.message));
//     } else if (response is Message) {
//       emit(BidError(message: response.content));
//     }
//   }
// }
