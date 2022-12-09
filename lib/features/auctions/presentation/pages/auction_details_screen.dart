// import 'dart:async';
//
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:elite_auction/core/constants/constant_widgets.dart';
// import 'package:elite_auction/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
// import 'package:elite_auction/core/widgets/TryRequest.dart';
// import 'package:elite_auction/core/widgets/loading.dart';
// import 'package:elite_auction/features/auctions/data/auction.dart';
// import 'package:elite_auction/features/auctions/domain/auction_details_cubit.dart';
// import 'package:elite_auction/features/auctions/domain/normal_auction_domain/timer_cubit.dart';
// import 'package:elite_auction/features/auctions/presentation/pages/normal_auction_screen.dart';
// import 'package:elite_auction/features/auctions/presentation/widgets/auctions_shared_app_bar.dart';
// import 'package:elite_auction/features/user/prsentation/pages/sign_in_screen.dart';
// import 'package:expandable_page_view/expandable_page_view.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../AppSettings.dart';
// import '../../../../core/constants/AppColors.dart';
// import '../../../../core/widgets/build_indicator.dart';
// import '../../../../features/Home/presentation/widgets/build_product_image.dart';
// import '../../../../global.dart';
// import '../widgets/time_card.dart';
//
// class AuctionShowScreen extends StatefulWidget {
//   final int auctionId;
//   final String auctionName;
//   final String startBidDate;
//   final String endBidDate;
//
//   const AuctionShowScreen({
//     Key key,
//     this.auctionId,
//     this.auctionName,
//     this.startBidDate,
//     this.endBidDate,
//   }) : super(key: key);
//
//   @override
//   State<AuctionShowScreen> createState() => _AuctionShowScreenState();
// }
//
// class _AuctionShowScreenState extends State<AuctionShowScreen> {
//   int index = 0;
//   DateTime dateFormatForStart;
//   DateTime dateFormatForEnd;
//   TimerCubit timerCubit = TimerCubit();
//
//   @override
//   void initState() {
//     if (AppSharedPreferences.accessToken != null)
//       context
//           .read<AuctionDetailsCubit>()
//           .getAuction(auctionId: widget.auctionId, withEnrollment: true);
//     else
//       context.read<AuctionDetailsCubit>().getAuction(
//             auctionId: widget.auctionId,
//           );
//     timerCubit.initTimer(
//         startBidDate: widget.startBidDate, endBidDate: widget.endBidDate);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     timerCubit.disposeTimer();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext auctionContext) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AuctionsSharedAppBar(
//             context: context, appBarTitle: widget.auctionName, canGoBack: true),
//         backgroundColor: AppColors.kWhite,
//         body: BlocConsumer<AuctionDetailsCubit, AuctionDetailsState>(
//           listener: (context, state) {
//             if (state is EnrollInAuctionSuccess)
//               return Fluttertoast.showToast(
//                   msg: state.message, toastLength: Toast.LENGTH_SHORT);
//             else if (state is EnrollInAuctionError)
//               return Fluttertoast.showToast(
//                   msg: state.message, toastLength: Toast.LENGTH_SHORT);
//           },
//           builder: (context, state) {
//             if (state is AuctionDetailsLoading)
//               return LoadingCircularWidget();
//             else if (state is AuctionDetailsError)
//               return TryRequest(
//                   onTry: AppSharedPreferences.accessToken != null
//                       ? auctionContext.read<AuctionDetailsCubit>().getAuction(
//                           auctionId: widget.auctionId, withEnrollment: true)
//                       : auctionContext.read<AuctionDetailsCubit>().getAuction(
//                             auctionId: widget.auctionId,
//                           ));
//             else if (state is AuctionDetailsSuccess) {
//               final auction = state.auction;
//               return Container(
//                 child: Column(
//                   children: [
//                     Expanded(
//                       flex: 9,
//                       child: ListView(
//                         shrinkWrap: true,
//                         primary: false,
//                         physics: ScrollPhysics(),
//                         children: [
//                           _buildAuctionImagesSlider(auction),
//                           SizedBox(
//                             height: 5.0.h,
//                           ),
//                           BuildIndicator(
//                               length: auction.auctionImages.length,
//                               index: index),
//                           SizedBox(
//                             height: 5.0.h,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 5.0.w),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   width: 50.0.w,
//                                   child: FittedBox(
//                                     fit: BoxFit.scaleDown,
//                                     alignment: lang
//                                         ? Alignment.centerLeft
//                                         : Alignment.centerRight,
//                                     child: Text(
//                                       auction.auctionName,
//                                       style: TextStyle(
//                                         fontFamily: lang
//                                             ? 'Walter_Becker'
//                                             : 'Farsi_Far_Tow',
//                                         fontSize: 16.0.sp,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   width: 40.0.w,
//                                   padding: EdgeInsets.all(2.0.w),
//                                   decoration: ConstantWidgets
//                                       .circuledBoxWithExtraLightShadow,
//                                   child: FittedBox(
//                                     child: Text(
//                                       "Auction Starting Price".tr() +
//                                           '  ${auction.auctionStartingPrice}',
//                                       textAlign: TextAlign.center,
//                                       maxLines: 2,
//                                       style: TextStyle(
//                                           fontFamily: lang
//                                               ? 'Walter_Becker'
//                                               : 'Farsi_Far_Tow',
//                                           fontSize: 13.0.sp,
//                                           color: Colors.green,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(horizontal: 5.0.w),
//                             margin: EdgeInsets.only(top: 3.0.w, bottom: 2.0.w),
//                             width: 45.0.w,
//                             child: Text(
//                               "Start".tr() + ' : ${auction.startAt}',
//                               style: TextStyle(
//                                   fontFamily:
//                                       lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                                   fontSize: 14.0.sp,
//                                   color: Colors.red),
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(horizontal: 5.0.w),
//                             margin: EdgeInsets.symmetric(vertical: 2.0.w),
//                             width: 45.0.w,
//                             child: Text(
//                               "End".tr() + ' : ${auction.endAt}',
//                               style: TextStyle(
//                                   fontFamily:
//                                       lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                                   fontSize: 14.0.sp,
//                                   color: Colors.red),
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(horizontal: 5.0.w),
//                             margin: EdgeInsets.symmetric(vertical: 2.0.w),
//                             child: Text(
//                               "Number of enrolled users".tr() +
//                                   ' : ${auction.userEnrollmentsCount}',
//                               style: TextStyle(
//                                   fontFamily:
//                                       lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                                   fontSize: 14.0.sp,
//                                   color: Colors.green),
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(horizontal: 5.0.w),
//                             margin: EdgeInsets.symmetric(vertical: 2.0.w),
//                             child: AutoSizeText(
//                               "Description".tr() +
//                                   ' : ' +
//                                   auction.auctionMobileDescription,
//                               style: TextStyle(
//                                   fontFamily:
//                                       lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                                   fontSize: 16.0.sp,
//                                   color: AppColors.kBlack),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: _buildBottomButton(auction),
//                     ),
//                   ],
//                 ),
//               );
//             }
//             return SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }
//
//   _buildBottomButton(AuctionDetailsResponseModel auction) {
//     if (auction.auctionStatus == 'finished') return Container();
//     if (AppSharedPreferences.accessToken == null)
//       return _buildAuctionDetailsBottomButton(
//           onPressed: () {
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => SignInScreen()));
//           },
//           title: 'Login to enroll'.tr());
//     if (!context.read<AuctionDetailsCubit>().isEnrolled)
//       return _buildAuctionDetailsBottomButton(
//           title: 'Enroll !'.tr(),
//           onPressed: () {
//             (context
//                 .read<AuctionDetailsCubit>()
//                 .enrollInAuction(auctionId: widget.auctionId));
//           });
//     else
//       return _buildWidgetDependingOnTime();
//   }
//
//   Container _buildAuctionDetailsBottomButton(
//       {@required String title, @required Function onPressed}) {
//     return Container(
//       width: 50.0.w,
//       decoration: BoxDecoration(
//         color: AppColors.kGreen,
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(8.0.w),
//           topLeft: Radius.circular(8.0.w),
//         ),
//       ),
//       child: MaterialButton(
//         onPressed: onPressed,
//         child: FittedBox(
//           fit: BoxFit.scaleDown,
//           child: Text(
//             title,
//             style: TextStyle(
//                 fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                 color: AppColors.kWhite,
//                 fontSize: 18.0.sp),
//           ),
//         ),
//       ),
//     );
//   }
//
//   BlocBuilder _buildWidgetDependingOnTime() {
//     return BlocBuilder<TimerCubit, TimerState>(
//         bloc: timerCubit,
//         builder: (context, state) {
//           if (state.isPendingStartBefore24Hours)
//             return _buildPendingStartTimerWidget();
//           else if (state.isOngoing)
//             return _buildAuctionDetailsBottomButton(
//                 title: 'Go To Auction'.tr(),
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => NormalAuctionScreen(
//                         auctionName: widget.auctionName,
//                         auctionId: widget.auctionId,
//                         startBidDate: widget.startBidDate,
//                         endBidDate: widget.endBidDate,
//                       ),
//                     ),
//                   );
//                 });
//
//           return SizedBox.shrink();
//         });
//   }
//
//   Container _buildPendingStartTimerWidget() {
//     return Container(
//         decoration: BoxDecoration(
//           color: AppColors.kGreen,
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(8.0.w),
//             topLeft: Radius.circular(8.0.w),
//           ),
//         ),
//         width: 60.0.w,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               child: FittedBox(
//                 fit: BoxFit.scaleDown,
//                 alignment: lang ? Alignment.centerLeft : Alignment.centerRight,
//                 child: Text(
//                   "Start in ".tr(),
//                   style: TextStyle(
//                       fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                       fontSize: 12.0.sp,
//                       color: AppColors.kWhite),
//                 ),
//               ),
//             ),
//             timerRow()
//           ],
//         ));
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
//
//   Container _buildAuctionImagesSlider(AuctionDetailsResponseModel auction) {
//     return Container(
//       width: 100.0.w,
//       height: 33.0.h,
//       child: ExpandablePageView(
//         onPageChanged: (imageIndex) {
//           setState(() {
//             index = imageIndex;
//           });
//         },
//         physics: PageScrollPhysics(),
//         children: [
//           if (auction.auctionImages.isEmpty)
//             BuildProductImage(
//               productImage: AppSettings.BASE_URL + auction.auctionMainImage,
//             ),
//           for (var image in auction.auctionImages)
//             BuildProductImage(
//               productImage: AppSettings.BASE_URL + image.imageName,
//             ),
//         ],
//       ),
//     );
//   }
// }
