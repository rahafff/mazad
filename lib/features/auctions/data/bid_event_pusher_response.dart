// class BidEventPusherResponse {
//   AuctionLiveData auctionLiveData;
//
//   BidEventPusherResponse({this.auctionLiveData});
//
//   BidEventPusherResponse.fromJson(Map<String, dynamic> json) {
//     auctionLiveData = json['auction_live_data'] != null
//         ? new AuctionLiveData.fromJson(json['auction_live_data'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.auctionLiveData != null) {
//       data['auction_live_data'] = this.auctionLiveData.toJson();
//     }
//     return data;
//   }
// }
//
// class AuctionLiveData {
//   List<AuctionTopBidders> auctionTopBidders;
//   int currentHighestBid;
//   int totalEnrollments;
//   int totalBidders;
//
//   AuctionLiveData(
//       {this.auctionTopBidders,
//       this.currentHighestBid,
//       this.totalEnrollments,
//       this.totalBidders});
//
//   AuctionLiveData.fromJson(Map<String, dynamic> json) {
//     if (json['auction_top_bidders'] != null) {
//       auctionTopBidders = new List<AuctionTopBidders>();
//       json['auction_top_bidders'].forEach((v) {
//         auctionTopBidders.add(new AuctionTopBidders.fromJson(v));
//       });
//     }
//     currentHighestBid = json['current_highest_bid'];
//     totalEnrollments = json['total_enrollments'];
//     totalBidders = json['total_bidders'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.auctionTopBidders != null) {
//       data['auction_top_bidders'] =
//           this.auctionTopBidders.map((v) => v.toJson()).toList();
//     }
//     data['current_highest_bid'] = this.currentHighestBid;
//     data['total_enrollments'] = this.totalEnrollments;
//     data['total_bidders'] = this.totalBidders;
//     return data;
//   }
// }
//
// class AuctionTopBidders {
//   int bidValue;
//   String userDisplayName;
//
//   AuctionTopBidders({this.bidValue, this.userDisplayName});
//
//   AuctionTopBidders.fromJson(Map<String, dynamic> json) {
//     bidValue = json['bid_value'];
//     userDisplayName = json['user_display_name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['bid_value'] = this.bidValue;
//     data['user_display_name'] = this.userDisplayName;
//     return data;
//   }
// }
