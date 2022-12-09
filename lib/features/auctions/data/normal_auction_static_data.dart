// import 'package:elite_auction/core/API/CoreModels/base_result_model.dart';
//
// class NormalAuctionStaticDataResponseModel extends BaseResultModel {
//   Auction auction;
//
//   NormalAuctionStaticDataResponseModel({this.auction});
//
//   NormalAuctionStaticDataResponseModel.fromJson(Map<String, dynamic> json) {
//     auction =
//         json['auction'] != null ? new Auction.fromJson(json['auction']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.auction != null) {
//       data['auction'] = this.auction.toJson();
//     }
//     return data;
//   }
// }
//
// class Auction {
//   int id;
//   String auctionName;
//   String auctionDescription;
//   String auctionMobileDescription;
//   String auctionMainImage;
//   String endAt;
//   int userEnrollmentsCount;
//   String userDisplayName;
//   List<AuctionTopBidders> auctionTopBidders;
//   int currentHighestBid;
//   int totalEnrollments;
//   int totalBidders;
//   List<AuctionComment> auctionComments;
//   List<Images> images;
//
//   Auction(
//       {this.id,
//       this.auctionName,
//       this.auctionDescription,
//       this.auctionMobileDescription,
//       this.auctionMainImage,
//       this.endAt,
//       this.userEnrollmentsCount,
//       this.userDisplayName,
//       this.auctionTopBidders,
//       this.currentHighestBid,
//       this.totalEnrollments,
//       this.totalBidders,
//       this.auctionComments,
//       this.images});
//
//   Auction.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     auctionName = json['auction_name'];
//     auctionDescription = json['auction_description'];
//     auctionMobileDescription = json['auction_mobile_description'];
//     auctionMainImage = json['auction_main_image'];
//     endAt = json['end_at'];
//     userEnrollmentsCount = json['user_enrollments_count'];
//     userDisplayName = json['user_display_name'];
//     if (json['auction_top_bidders'] != null) {
//       auctionTopBidders = new List<AuctionTopBidders>();
//       json['auction_top_bidders'].forEach((v) {
//         auctionTopBidders.add(new AuctionTopBidders.fromJson(v));
//       });
//     }
//     currentHighestBid = json['current_highest_bid'];
//     totalEnrollments = json['total_enrollments'];
//     totalBidders = json['total_bidders'];
//     if (json['auction_comments'] != null) {
//       auctionComments = new List<AuctionComment>();
//       json['auction_comments'].forEach((v) {
//         auctionComments.add(new AuctionComment.fromJson(v));
//       });
//     }
//     if (json['images'] != null) {
//       images = new List<Images>();
//       json['images'].forEach((v) {
//         images.add(new Images.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['auction_name'] = this.auctionName;
//     data['auction_description'] = this.auctionDescription;
//     data['auction_mobile_description'] = this.auctionMobileDescription;
//     data['auction_main_image'] = this.auctionMainImage;
//     data['end_at'] = this.endAt;
//     data['user_enrollments_count'] = this.userEnrollmentsCount;
//     data['user_display_name'] = this.userDisplayName;
//     if (this.auctionTopBidders != null) {
//       data['auction_top_bidders'] =
//           this.auctionTopBidders.map((v) => v.toJson()).toList();
//     }
//     data['current_highest_bid'] = this.currentHighestBid;
//     data['total_enrollments'] = this.totalEnrollments;
//     data['total_bidders'] = this.totalBidders;
//     if (this.auctionComments != null) {
//       data['auction_comments'] =
//           this.auctionComments.map((v) => v.toJson()).toList();
//     }
//     if (this.images != null) {
//       data['images'] = this.images.map((v) => v.toJson()).toList();
//     }
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
//
// class AuctionComment {
//   int auctionId;
//   String userDisplayName;
//   String comment;
//   String createdAt;
//
//   AuctionComment(
//       {this.auctionId, this.userDisplayName, this.comment, this.createdAt});
//
//   AuctionComment.fromJson(Map<String, dynamic> json) {
//     auctionId = json['auction_id'];
//     userDisplayName = json['user_display_name'];
//     comment = json['comment'];
//     createdAt = json['created_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['auction_id'] = this.auctionId;
//     data['user_display_name'] = this.userDisplayName;
//     data['comment'] = this.comment;
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }
//
// class Images {
//   int id;
//   int auctionId;
//   String imageName;
//   int imageSort;
//
//   Images({this.id, this.auctionId, this.imageName, this.imageSort});
//
//   Images.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     auctionId = json['auction_id'];
//     imageName = json['image_name'];
//     imageSort = json['image_sort'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['auction_id'] = this.auctionId;
//     data['image_name'] = this.imageName;
//     data['image_sort'] = this.imageSort;
//     return data;
//   }
// }
