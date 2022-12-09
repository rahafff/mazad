// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:elite_auction/features/auctions/domain/pusher_cubit.dart';
// import 'package:meta/meta.dart';
//
// part 'timer_state.dart';
//
// class TimerCubit extends Cubit<TimerState> {
//   TimerCubit() : super(TimerState());
//   Timer timer;
//   String startBidDate;
//   String endBidDate;
//   DateTime dateTimeForStart;
//   DateTime dateTimeForEnd;
//   void initTimer({String startBidDate, String endBidDate}) {
//     this.startBidDate = startBidDate;
//     this.endBidDate = endBidDate;
//     stringToDateTimeParser();
//     checkTimeAndAssignTimeParametersAndStartTimer();
//   }
//
//   void stringToDateTimeParser() {
//     dateTimeForStart = DateTime.parse(startBidDate);
//     dateTimeForEnd = DateTime.parse(endBidDate);
//   }
//
//   void checkTimeAndAssignTimeParametersAndStartTimer() {
//     if (isPendingStart()) {
//       emit(state.copyWith(isPendingStart: true));
//     }
//     if (isPendingStartBefore24Hours()) {
//       emit(state.copyWith(
//           isPendingStart: false, isPendingStartBefore24Hours: true));
//       assignTimeParametersForPendingStartAuction();
//       startTimer();
//     } else if (isOnGoing()) {
//       emit(state.copyWith(isPendingStartBefore24Hours: false, isOngoing: true));
//       assignTimeParametersForOnGoingAuction();
//       startTimer();
//     } else if (isEnded()) {
//       emit(state.copyWith(isOngoing: false, isEnded: true));
//       // assignTimeParametersForWaitingTimeAfterAuctionEnds();
//       // startWaitingTimer();
//     }
//   }
//
//   // void assignTimeParametersForWaitingTimeAfterAuctionEnds() {
//   //   emit(state.copyWith(seconds: 1));
//   // }
//
//   bool isEnded() {
//     return DateTime.now().isAfter(dateTimeForEnd);
//   }
//
//   bool isOnGoing() {
//     return DateTime.now().isAfter(dateTimeForStart) &&
//         DateTime.now().isBefore(dateTimeForEnd);
//   }
//
//   bool isPendingStart() {
//     return DateTime.now().isBefore(
//       dateTimeForStart.subtract(
//         Duration(hours: 24),
//       ),
//     );
//   }
//
//   bool isPendingStartBefore24Hours() {
//     return DateTime.now().isAfter(
//           dateTimeForStart.subtract(
//             Duration(hours: 24),
//           ),
//         ) &&
//         DateTime.now().isBefore(dateTimeForStart);
//   }
//
//   void assignTimeParametersForPendingStartAuction() {
//     Duration duration = dateTimeForStart.difference(DateTime.now());
//     emit(state.copyWith(hours: duration.inSeconds ~/ 3600));
//     emit(state.copyWith(
//         minutes: (duration.inSeconds - state.hours * 3600) ~/ 60));
//     emit(state.copyWith(
//         seconds: duration.inSeconds - state.hours * 3600 - state.minutes * 60));
//   }
//
//   void assignTimeParametersForOnGoingAuction() {
//     Duration duration = dateTimeForEnd.difference(DateTime.now());
//     emit(state.copyWith(hours: duration.inSeconds ~/ 3600));
//     emit(state.copyWith(
//         minutes: (duration.inSeconds - state.hours * 3600) ~/ 60));
//     emit(state.copyWith(
//         seconds: duration.inSeconds - state.hours * 3600 - state.minutes * 60));
//   }
//
//   void startTimer() {
//     timer = Timer.periodic(Duration(seconds: 1), (_) {
//       if (state.seconds > 0) {
//         emit(state.copyWith(seconds: --state.seconds));
//       } else if (state.seconds == 0 && state.minutes > 0) {
//         emit(state.copyWith(seconds: 59, minutes: --state.minutes));
//       } else if (state.seconds == 0 && state.minutes == 0 && state.hours > 0)
//         emit(state.copyWith(seconds: 59, minutes: 59, hours: --state.hours));
//       else if (state.seconds == 0 && state.minutes == 0 && state.hours == 0) {
//         timer.cancel();
//         checkTimeAndAssignTimeParametersAndStartTimer();
//       }
//     });
//   }
//
//   // void startWaitingTimer() {
//   //   timer = Timer.periodic(Duration(seconds: 1), (_) {
//   //     emit(state.copyWith(seconds: ++state.seconds));
//   //   });
//   // }
//
//   // void cancelTimerWhenThePusherCloseEventArrives() {
//   //   timer.cancel();
//   // }
//
//   void disposeTimer() {
//     if (timer != null) timer.cancel();
//   }
// }
