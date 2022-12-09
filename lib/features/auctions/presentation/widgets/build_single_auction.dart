// import 'package:badges/badges.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:elite_auction/features/auctions/domain/normal_auction_domain/timer_cubit.dart';
// import 'package:elite_auction/features/auctions/presentation/widgets/build_single_auction_item_image.dart';
// import 'package:elite_auction/features/auctions/presentation/widgets/time_card.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../core/constants/AppColors.dart';
// import '../../../../core/constants/constant_widgets.dart';
// import '../../../../global.dart';
// import '../pages/auction_details_screen.dart';
//
// class BuildSingleAuction extends StatefulWidget {
//   const BuildSingleAuction({
//     Key key,
//     this.auctionImage,
//     this.auctionName,
//     this.userEnrollmentCount,
//     this.startBidDate,
//     this.endBidDate,
//     this.currentBid,
//     this.onTappingAuction,
//     this.status,
//   }) : super(key: key);
//   final String auctionImage;
//   final String auctionName;
//   final String userEnrollmentCount;
//   final String startBidDate;
//   final String endBidDate;
//   final String status;
//   final int currentBid;
//
//   final Function onTappingAuction;
//
//   @override
//   _BuildSingleAuctionState createState() => _BuildSingleAuctionState();
// }
//
// class _BuildSingleAuctionState extends State<BuildSingleAuction> {
//   TimerCubit timerCubit = TimerCubit();
//
//   @override
//   void initState() {
//     timerCubit.initTimer(
//         startBidDate: widget.startBidDate, endBidDate: widget.endBidDate);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TimerCubit, TimerState>(
//       bloc: timerCubit,
//       builder: (context, state) {
//         if (state.isPendingStartBefore24Hours || state.isPendingStart)
//           return buildBadge(badgeColor: Colors.amber);
//         else if (state.isOngoing)
//           return buildBadge(badgeColor: AppColors.kGreen);
//         else
//           return buildBadge(badgeColor: Colors.redAccent.shade200);
//       },
//     );
//   }
//
//   Badge buildBadge({Color badgeColor}) {
//     return Badge(
//       shape: BadgeShape.square,
//       borderRadius: BorderRadius.circular(5.0.w),
//       badgeColor: badgeColor,
//       elevation: 0,
//       badgeContent: BlocBuilder<TimerCubit, TimerState>(
//         bloc: timerCubit,
//         builder: (context, state) {
//           if (state.isPendingStart || state.isPendingStartBefore24Hours)
//             return Text(
//               'Pending'.tr(), //todo translate
//               style: TextStyle(
//                   fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                   color: AppColors.kWhite,
//                   fontSize: 10.0.sp),
//             );
//           else if (state.isOngoing)
//             return Text(
//               'On Going'.tr(), //todo translate
//               style: TextStyle(
//                   fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                   color: AppColors.kWhite,
//                   fontSize: 10.0.sp),
//             );
//           if (state.isEnded)
//             return Text(
//               'Finished'.tr(), //todo translate
//               style: TextStyle(
//                   fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                   color: AppColors.kWhite,
//                   fontSize: 10.0.sp),
//             );
//           return SizedBox.shrink();
//         },
//       ),
//       position: BadgePosition.topEnd(top: 6.5.w, end: 6.0.w),
//       alignment: Alignment.topRight,
//       child: ListTile(
//         title: GestureDetector(
//           onTap: widget.onTappingAuction,
//           child: Container(
//             decoration: BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.circular(2.0.w)),
//             height: 20.0.h,
//             width: 88.0.w,
//             margin: EdgeInsets.only(
//               top: 1.0.h,
//               bottom: 1.0.h,
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 BuildSingleAuctionItemImage(
//                   itemImage: widget.auctionImage,
//                 ),
//                 Container(
//                   width: 50.0.w,
//                   height: 23.0.h,
//                   margin: EdgeInsets.symmetric(horizontal: 2.0.w),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: 30.0.w,
//                         child: FittedBox(
//                           fit: BoxFit.scaleDown,
//                           alignment: lang
//                               ? Alignment.centerLeft
//                               : Alignment.centerRight,
//                           child: Text(
//                             widget.auctionName,
//                             style: TextStyle(
//                                 fontFamily:
//                                     lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12.0.sp),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 30.0.w,
//                         child: FittedBox(
//                           fit: BoxFit.scaleDown,
//                           alignment: lang
//                               ? Alignment.centerLeft
//                               : Alignment.centerRight,
//                           child: RichText(
//                             text: TextSpan(
//                                 text: "Current_bid".tr(),
//                                 style: TextStyle(
//                                     fontFamily: lang
//                                         ? 'Walter_Becker'
//                                         : 'Farsi_Far_Tow',
//                                     fontSize: 12.0.sp,
//                                     color: AppColors.kGray.withOpacity(0.4)),
//                                 children: [
//                                   TextSpan(
//                                     text: ' ${widget.currentBid}',
//                                     style: TextStyle(
//                                         fontFamily: lang
//                                             ? 'Walter_Becker'
//                                             : 'Farsi_Far_Tow',
//                                         fontSize: 12.0.sp,
//                                         color: AppColors.kGreen),
//                                   ),
//                                 ]),
//                           ),
//                         ),
//                       ),
//                       RichText(
//                         text: TextSpan(
//                             text: "Users Enrolled".tr(),
//                             style: TextStyle(
//                                 fontFamily:
//                                     lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                                 fontSize: 12.0.sp,
//                                 color: AppColors.kGray.withOpacity(0.4)),
//                             children: [
//                               TextSpan(
//                                 text: ' ${widget.userEnrollmentCount}',
//                                 style: TextStyle(
//                                     fontFamily: lang
//                                         ? 'Walter_Becker'
//                                         : 'Farsi_Far_Tow',
//                                     fontSize: 12.0.sp,
//                                     color: AppColors.kGreen),
//                               ),
//                             ]),
//                       ),
//                       SizedBox(
//                         height: 2.0.h,
//                       ),
//                       BlocBuilder<TimerCubit, TimerState>(
//                           bloc: timerCubit,
//                           builder: (context, state) {
//                             if (state.isPendingStart)
//                               return Container(
//                                 width: 60.0.w,
//                                 child: Container(
//                                   child: FittedBox(
//                                     fit: BoxFit.scaleDown,
//                                     alignment: lang
//                                         ? Alignment.centerLeft
//                                         : Alignment.centerRight,
//                                     child: Text(
//                                       "Start at : ".tr() + widget.startBidDate,
//                                       style: TextStyle(
//                                           fontFamily: lang
//                                               ? 'Walter_Becker'
//                                               : 'Farsi_Far_Tow',
//                                           fontSize: 12.0.sp,
//                                           color: AppColors.kGreen),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             else if (state.isPendingStartBefore24Hours)
//                               return Container(
//                                 width: 60.0.w,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: FittedBox(
//                                         fit: BoxFit.scaleDown,
//                                         alignment: lang
//                                             ? Alignment.centerLeft
//                                             : Alignment.centerRight,
//                                         child: Text(
//                                           "Start in ",
//                                           style: TextStyle(
//                                               fontFamily: lang
//                                                   ? 'Walter_Becker'
//                                                   : 'Farsi_Far_Tow',
//                                               fontSize: 12.0.sp,
//                                               color: AppColors.kGreen),
//                                         ),
//                                       ),
//                                     ),
//                                     timerRow()
//                                   ],
//                                 ),
//                               );
//                             else if (state.isOngoing)
//                               return Container(
//                                 width: 60.0.w,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       child: FittedBox(
//                                         alignment: lang
//                                             ? Alignment.centerLeft
//                                             : Alignment.centerRight,
//                                         fit: BoxFit.scaleDown,
//                                         child: Text(
//                                           "End in ".tr(),
//                                           style: TextStyle(
//                                               fontFamily: lang
//                                                   ? 'Walter_Becker'
//                                                   : 'Farsi_Far_Tow',
//                                               fontSize: 12.0.sp,
//                                               color: Colors.red),
//                                         ),
//                                       ),
//                                     ),
//                                     timerRow()
//                                   ],
//                                 ),
//                               );
//                             return SizedBox.shrink();
//                           })
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget timerRow() {
//     return Row(
//       children: [
//         TimeCard(
//           time: timerCubit.state.hours.toString(),
//         ),
//         SizedBox(
//           width: 1.0.w,
//         ),
//         TimeCard(time: timerCubit.state.minutes.toString()),
//         SizedBox(
//           width: 1.0.w,
//         ),
//         TimeCard(time: timerCubit.state.seconds.toString()),
//       ],
//     );
//   }
// }
