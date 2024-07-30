String formatDuration(int totalSeconds) {
  int hours = totalSeconds ~/ 3600;
  int minutes = (totalSeconds % 3600) ~/ 60;
  int seconds = totalSeconds % 60;

  if (hours > 0) {
    return '${hours}h ${minutes}m ${seconds}s';
  } else if (minutes > 0) {
    return '${minutes}m ${seconds}s';
  } else {
    return '${seconds}s';
  }
}
//${totalSeconds >= 300 ? '' : '${seconds}s'}';
//'${minutes}m ${seconds}s';


// String formatDuration(int timeLeftData) {
//   int h = 0;
//   int m = 0;
//   int s = 0;
//   if(timeLeftData >= 3600){
//     h = timeLeftData ~/ 3600;
//     m = (timeLeftData - (h * 3600)) ~/ 60;
//     s = timeLeftData - (h * 3600) - (m * 60);
//   }
//   if(timeLeftData <3600 && timeLeftData > 60){
//     m = timeLeftData ~/ 60;
//     s = timeLeftData - (m * 60);
//   }
//   if(timeLeftData <= 60){
//     s = timeLeftData;
//   }
//   String twoDigits(int n) => n.toString().padLeft(2, '0');
//   return '${twoDigits(h)}h ${twoDigits(m)}m ${twoDigits(s)}s';
// }
