// import 'package:elite_auction/core/API/CoreModels/base_result_model.dart';
//
// class AuctionDetailsResponseModel extends BaseResultModel {
//   int id;
//   String auctionName;
//   String auctionMobileDescription;
//   String auctionMainImage;
//   int auctionStartingPrice;
//   String startAt;
//   String endAt;
//   String auctionStatus;
//   int userEnrollmentsCount;
//   bool isEnrolled;
//   List<Images> auctionImages;
//   AuctionDetailsResponseModel(
//       {this.id,
//       this.auctionName,
//       this.auctionMobileDescription,
//       this.auctionMainImage,
//       this.auctionStartingPrice,
//       this.startAt,
//       this.endAt,
//       this.auctionStatus,
//       this.userEnrollmentsCount,
//       this.isEnrolled});
//
//   AuctionDetailsResponseModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     auctionName = json['auction_name'];
//     auctionMobileDescription = json['auction_mobile_description'];
//     auctionMainImage = json['auction_main_image'];
//     auctionStartingPrice = json['auction_starting_price'];
//     startAt = json['start_at'];
//     endAt = json['end_at'];
//     auctionStatus = json['auction_status'];
//     userEnrollmentsCount = json['user_enrollments_count'];
//     isEnrolled = json['is_enrolled'];
//     if (json['images'] != null) {
//       auctionImages = <Images>[];
//       json['images'].forEach((v) {
//         auctionImages.add(new Images.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['auction_name'] = this.auctionName;
//     data['auction_mobile_description'] = this.auctionMobileDescription;
//     data['auction_main_image'] = this.auctionMainImage;
//     data['auction_starting_price'] = this.auctionStartingPrice;
//     data['start_at'] = this.startAt;
//     data['end_at'] = this.endAt;
//     data['auction_status'] = this.auctionStatus;
//     data['user_enrollments_count'] = this.userEnrollmentsCount;
//     data['is_enrolled'] = this.isEnrolled;
//
//     if (this.auctionImages != null) {
//       data['images'] = this.auctionImages.map((v) => v.toJson()).toList();
//     }
//
//     return data;
//   }
// }
//
// class Images {
//   int id;
//   int auctionId;
//   String imageName;
//
//   Images({
//     this.id,
//     this.auctionId,
//     this.imageName,
//   });
//
//   Images.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     auctionId = json['auction_id'];
//     imageName = json['image_name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['auction_id'] = this.auctionId;
//     data['image_name'] = this.imageName;
//
//     return data;
//   }
// }
