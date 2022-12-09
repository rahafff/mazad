// import 'package:easy_localization/easy_localization.dart';
// import 'package:elite_auction/AppSettings.dart';
// import 'package:elite_auction/core/constants/app_assets.dart';
// import 'package:elite_auction/core/constants/constants.dart';
// import 'package:elite_auction/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
// import 'package:elite_auction/core/widgets/loading.dart';
// import 'package:elite_auction/features/auctions/data/auction.dart';
// import 'package:elite_auction/features/auctions/domain/auctions_cubit.dart';
// import 'package:elite_auction/features/auctions/presentation/widgets/auctions_shared_app_bar.dart';
// import 'package:elite_auction/features/auctions/presentation/widgets/build_single_auction.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../core/constants/AppColors.dart';
// import '../../../../global.dart';
// import 'auction_details_screen.dart';
//
// enum MenuItem { Pending, OnGoing, Finished }
//
// class AuctionsScreen extends StatefulWidget {
//   @override
//   _AuctionsScreenState createState() => _AuctionsScreenState();
// }
//
// class _AuctionsScreenState extends State<AuctionsScreen> {
//   final RefreshController refreshController =
//       RefreshController(initialRefresh: false);
//   final ScrollController scrollController = ScrollController();
//   String selectedFilter;
//   bool isFiltering = false;
//
//   @override
//   void dispose() {
//     refreshController.dispose();
//     scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     if (AppSharedPreferences.accessToken == null)
//       context.read<AuctionsCubit>().getAuctions();
//     else
//       context.read<AuctionsCubit>().getAuctions(withEnrollment: true);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext auctionContext) {
//     return SafeArea(
//       child: Scaffold(
//           appBar: AppBar(
//             elevation: 0,
//             backgroundColor: AppColors.kGreen,
//             actions: [
//               isFiltering
//                   ? IconButton(
//                       onPressed: () {
//                         auctionContext.read<AuctionsCubit>().getAuctions();
//                         setState(() {
//                           isFiltering = false;
//                         });
//                       },
//                       icon: Icon(
//                         lang ? Icons.arrow_forward : Icons.arrow_back,
//                         color: AppColors.white,
//                       ))
//                   : Padding(
//                       padding: lang
//                           ? EdgeInsets.only(right: 2.0.w)
//                           : EdgeInsets.only(left: 2.0.w),
//                       child: PopupMenuButton<MenuItem>(
//                         itemBuilder: (context) => [
//                           PopupMenuItem(
//                             child: Text('filter by'.tr()),
//                             enabled: false,
//                           ),
//                           PopupMenuItem(
//                             child: Text(
//                               'Pending'.tr(),
//                               style: TextStyle(color: Colors.amber),
//                             ),
//                             value: MenuItem.Pending,
//                           ),
//                           PopupMenuItem(
//                             child: Text(
//                               'Ongoing'.tr(),
//                               style: TextStyle(color: AppColors.kGreen),
//                             ),
//                             value: MenuItem.OnGoing,
//                           ),
//                           PopupMenuItem(
//                             child: Text(
//                               'Finished'.tr(),
//                               style: TextStyle(color: Colors.blue),
//                             ),
//                             value: MenuItem.Finished,
//                           )
//                         ],
//                         icon: ImageIcon(
//                           AssetImage(AppAssets.buttonMenu),
//                         ),
//                         onSelected: (value) {
//                           if (value == MenuItem.Finished) {
//                             auctionContext
//                                 .read<AuctionsCubit>()
//                                 .getAuctions(auctionStatus: 'finished');
//                             setState(() {
//                               selectedFilter = 'finished';
//                               isFiltering = true;
//                             });
//                           } else if (value == MenuItem.Pending) {
//                             auctionContext
//                                 .read<AuctionsCubit>()
//                                 .getAuctions(auctionStatus: 'pending');
//                             setState(() {
//                               selectedFilter = 'pending';
//                               isFiltering = true;
//                             });
//                           } else if (value == MenuItem.OnGoing) {
//                             auctionContext
//                                 .read<AuctionsCubit>()
//                                 .getAuctions(auctionStatus: 'on_going');
//                             setState(() {
//                               selectedFilter = 'on_going';
//                               isFiltering = true;
//                             });
//                           }
//                         },
//                       ),
//                     ),
//             ],
//             centerTitle: true,
//             title: FittedBox(
//               child: RichText(
//                 text: TextSpan(
//                   text: 'Auctions'.tr(),
//                   style: TextStyle(
//                       fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                       fontSize: 16.0.sp,
//                       color: AppColors.kWhite,
//                       fontWeight: FontWeight.normal),
//                 ),
//               ),
//             ),
//           ),
//           backgroundColor: AppColors.kWhite,
//           body: Container(
//             color: AppColors.kGray.withOpacity(0.07),
//             child: BlocConsumer<AuctionsCubit, AuctionsState>(
//               listener: (context, state) {
//                 if (state is AuctionsError)
//                   Fluttertoast.showToast(msg: state.message);
//                 else if (state is AuctionsSuccess) {
//                   refreshController.refreshCompleted();
//
//                   if (state.currentPage ==
//                       auctionContext
//                           .read<AuctionsCubit>()
//                           .lastPageForAuctions) {
//                     refreshController.loadNoData();
//                   } else {
//                     refreshController.loadComplete();
//                   }
//                 }
//               },
//               builder: (context, state) {
//                 if (state is AuctionsError) {
//                   return Container(
//                     child: Center(
//                       child: Image.asset(
//                           lang ? AppAssets.noItemEn : AppAssets.noItemAr),
//                     ),
//                   );
//                 } else if (state is AuctionsLoading) {
//                   return Padding(
//                       padding: EdgeInsets.all(2.0.w),
//                       child: LoadingCircularWidget());
//                 } else if (state is AuctionsSuccess) {
//                   if (state.auctions.isEmpty || state.auctions == null)
//                     return Container(
//                       child: Center(
//                         child: Image.asset(
//                             lang ? AppAssets.noItemEn : AppAssets.noItemAr),
//                       ),
//                     );
//                   else
//                     return _smartRefresher(state.auctions, context);
//                 }
//
//                 return SizedBox.shrink();
//               },
//             ),
//           )),
//     );
//   }
//
//   _smartRefresher(
//       List<AuctionDetailsResponseModel> auctions, BuildContext context) {
//     return Scrollbar(
//       controller: scrollController,
//       child: SmartRefresher(
//         controller: refreshController,
//         enablePullUp: true,
//         enablePullDown: true,
//         header: WaterDropHeader(
//           waterDropColor: AppColors.kGreen,
//         ),
//         onRefresh: () {
//           AppSharedPreferences.accessToken == null
//               ? context.read<AuctionsCubit>().getAuctions(
//                   isRefreshing: true, auctionStatus: selectedFilter)
//               : context.read<AuctionsCubit>().getAuctions(
//                   isRefreshing: true,
//                   withEnrollment: true,
//                   auctionStatus: selectedFilter);
//         },
//         onLoading: () {
//           AppSharedPreferences.accessToken == null
//               ? context
//                   .read<AuctionsCubit>()
//                   .getAuctions(loadMore: true, auctionStatus: selectedFilter)
//               : context.read<AuctionsCubit>().getAuctions(
//                   loadMore: true,
//                   withEnrollment: true,
//                   auctionStatus: selectedFilter);
//         },
//         child: _buildAuctionsListView(auctions),
//         footer: CustomFooter(
//           builder: (BuildContext context, LoadStatus mode) {
//             Widget body;
//             if (mode == LoadStatus.idle) {
//               body = Text("No more Auctions".tr()); //todo translate
//             } else if (mode == LoadStatus.loading) {
//               body = CupertinoActivityIndicator();
//             } else if (mode == LoadStatus.failed) {
//               body = Text("Load Failed!Click retry!".tr());
//             } else if (mode == LoadStatus.canLoading) {
//               body = Text("release to load more".tr());
//             } else if (auctions.length < minimumNumberForPagnationMessage) {
//               body = Text("");
//             } else {
//               body = Text("No more Auctions".tr()); //todo translate
//             }
//             return Container(
//               height: 55.0,
//               child: Center(child: body),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   _buildAuctionsListView(List<AuctionDetailsResponseModel> auctions) {
//     return ListView.builder(
//       padding: EdgeInsets.only(top: 5.0.w),
//       shrinkWrap: true,
//       itemCount: auctions.length,
//       itemBuilder: (context, index) {
//         if (index == (auctions.length)) {
//           return SizedBox(
//             height: 4.5.h,
//           );
//         }
//         return BuildSingleAuction(
//             auctionImage:
//                 AppSettings.BASE_URL + auctions[index].auctionMainImage,
//             currentBid: auctions[index].auctionStartingPrice,
//             startBidDate: auctions[index].startAt,
//             endBidDate: auctions[index].endAt,
//             auctionName: auctions[index].auctionName,
//             userEnrollmentCount:
//                 auctions[index].userEnrollmentsCount.toString(),
//             status: auctions[index].auctionStatus,
//             onTappingAuction: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AuctionShowScreen(
//                     auctionName: auctions[index].auctionName,
//                     auctionId: auctions[index].id,
//                     endBidDate: auctions[index].endAt,
//                     startBidDate: auctions[index].startAt,
//                   ),
//                 ),
//               );
//             });
//       },
//     );
//   }
// }
