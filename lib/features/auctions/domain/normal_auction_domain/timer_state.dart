// part of 'timer_cubit.dart';
//
// class TimerState {
//   int seconds;
//   int minutes;
//   int hours;
//   int days;
//   bool isOngoing;
//   bool isPendingStartBefore24Hours;
//   bool isPendingStart;
//   bool isEnded;
//   TimerState copyWith({
//     bool isOngoing,
//     bool isEnded,
//     bool isPendingStartBefore24Hours,
//     bool isPendingStart,
//     int seconds,
//     int minutes,
//     int hours,
//     int days,
//   }) {
//     return TimerState(
//       seconds: seconds ?? this.seconds,
//       isOngoing: isOngoing ?? this.isOngoing,
//       isPendingStartBefore24Hours:
//           isPendingStartBefore24Hours ?? this.isPendingStartBefore24Hours,
//       isPendingStart: isPendingStart ?? this.isPendingStart,
//       isEnded: isEnded ?? this.isEnded,
//       minutes: minutes ?? this.minutes,
//       hours: hours ?? this.hours,
//       days: days ?? this.days,
//     );
//   }
//
//   TimerState({
//     this.isOngoing = false,
//     this.isPendingStartBefore24Hours = false,
//     this.isPendingStart = false,
//     this.isEnded = false,
//     this.seconds,
//     this.minutes,
//     this.hours,
//     this.days,
//   });
// }
