// part of 'pusher_cubit.dart';
//
// class PusherState {
//   BidEventPusherResponse bidEventPusherResponse;
//   CloseEventPusherResponse closeEventPusherResponse;
//   List<AuctionComment> commentEventPusherResponse;
//   var connectionStateChange;
//   var connectionError;
//   String errorMessage;
//
//   PusherState(
//       {this.bidEventPusherResponse,
//       this.connectionStateChange,
//       this.connectionError,
//       this.errorMessage,
//       this.closeEventPusherResponse,
//       this.commentEventPusherResponse});
//   PusherState dispose() {
//     return PusherState(
//         bidEventPusherResponse: null,
//         connectionStateChange: null,
//         connectionError: null,
//         errorMessage: null,
//         closeEventPusherResponse: null,
//         commentEventPusherResponse: null);
//   }
//
//   PusherState copyWith(
//       {BidEventPusherResponse bidEventPusherResponse,
//       var connectionStateChange,
//       var connectionError,
//       String errorMessage,
//       List<AuctionComment> commentEventPusherResponse,
//       CloseEventPusherResponse closeEventPusherResponse}) {
//     return PusherState(
//         bidEventPusherResponse:
//             bidEventPusherResponse ?? this.bidEventPusherResponse,
//         connectionStateChange:
//             connectionStateChange ?? this.connectionStateChange,
//         connectionError: connectionError ?? this.connectionError,
//         errorMessage: errorMessage ?? this.errorMessage,
//         commentEventPusherResponse:
//             commentEventPusherResponse ?? this.commentEventPusherResponse,
//         closeEventPusherResponse:
//             closeEventPusherResponse ?? this.closeEventPusherResponse);
//   }
// }
