// import 'package:elite_auction/core/constants/AppColors.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../core/constants/constant_widgets.dart';
// import '../../../../global.dart';
//
// class BuildBidChoice extends StatelessWidget {
//   const BuildBidChoice({
//     Key key,
//     this.bidChoice,
//     this.onTap,
//   }) : super(key: key);
//   final int bidChoice;
//   final Function onTap;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.all(2.0.h),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: AppColors.kGray.withOpacity(0.1),
//         ),
//         child: FittedBox(
//           child: Text(
//             bidChoice.toString(),
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
//                 fontSize: 10.0.sp),
//           ),
//         ),
//       ),
//     );
//   }
// }
