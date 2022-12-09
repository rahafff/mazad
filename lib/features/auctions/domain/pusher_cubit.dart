// import 'dart:convert';
// import 'dart:developer';
// import 'dart:ffi';
//
// import 'package:bloc/bloc.dart';
// import 'package:elite_auction/AppSettings.dart';
// import 'package:elite_auction/core/API/http/api_urls.dart';
// import 'package:elite_auction/features/auctions/data/bid_event_pusher_response.dart';
// import 'package:elite_auction/features/auctions/data/close_event_pusher_response.dart';
// import 'package:elite_auction/features/auctions/data/normal_auction_static_data.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:meta/meta.dart';
// import 'package:pusher_client/pusher_client.dart';
//
// part 'pusher_state.dart';
//
// class PusherCubit extends Cubit<PusherState> {
//   Channel channel;
//   PusherOptions options;
//   PusherClient pusherClient;
//   List<AuctionComment> auctionComments = [];
//   PusherCubit() : super(PusherState());
//   void initPusher({int auctionId}) async {
//     options = PusherOptions(
//       encrypted: true,
//       cluster: ApiURLs.PUSHER_APP_CLUSTER,
//     );
//     pusherClient = PusherClient(ApiURLs.PUSHER_APP_KEY, options,
//         enableLogging: true, autoConnect: true);
//     pusherClient.onConnectionError((error) {
//       emit(state.copyWith(connectionError: error));
//     });
//     pusherClient.onConnectionStateChange((connectionState) {
//       emit(state.copyWith(connectionStateChange: connectionState));
//     });
//     try {
//       await connectPusher();
//       await subscribeToChannel(auctionId);
//       await getBidEvent();
//       await getCommentEvent();
//       await getCloseEvent();
//     } catch (e) {
//       emit(state.copyWith(errorMessage: e.toString()));
//     }
//   }
//
//   Future<void> subscribeToChannel(int auctionId) async {
//     channel = await pusherClient.subscribe('auctions.${auctionId}');
//   }
//
//   Future<void> connectPusher() async {
//     await pusherClient.connect();
//   }
//
//   Future<void> pusherDisconnect({int auctionId}) async {
//     await channel.unbind("NewComment");
//     await channel.unbind("NewBid");
//     await channel.unbind("CloseAuction");
//     await pusherClient.unsubscribe("auctions.${auctionId}");
//     await pusherClient.disconnect();
//     auctionComments = [];
//     emit(state.dispose());
//   }
//
//   Future<dynamic> getBidEvent() async {
//     await channel.bind("NewBid", (event) {
//       Map<String, dynamic> json = jsonDecode(event.data);
//       var eventData = BidEventPusherResponse.fromJson(json);
//       emit(state.copyWith(bidEventPusherResponse: eventData));
//     });
//   }
//
//   Future<dynamic> getCloseEvent() async {
//     await channel.bind("CloseAuction", (event) {
//       Map<String, dynamic> json = jsonDecode(event.data);
//       print(event.data);
//       var eventData = CloseEventPusherResponse.fromJson(json);
//       emit(state.copyWith(closeEventPusherResponse: eventData));
//     });
//   }
//
//   Future<dynamic> getCommentEvent() async {
//     await channel.bind("NewComment", (event) {
//       Map<String, dynamic> json = jsonDecode(event.data);
//       var eventData = AuctionComment.fromJson(json);
//       auctionComments.insert(0, eventData);
//       emit(state.copyWith(commentEventPusherResponse: auctionComments));
//     });
//   }
// }
