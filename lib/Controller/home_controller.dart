import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<FlSpot> points = const [
    FlSpot(1, 0),
    FlSpot(2, 0),
    FlSpot(3, 0),
    FlSpot(4, 0),
  ];

  updatePoints({
    required double firstValue,
    required double secondValue,
    required double thirdValue,
    required double fourthValue,
  }) {
    points = [
      FlSpot(1, firstValue),
      FlSpot(2, secondValue),
      FlSpot(3, thirdValue),
      FlSpot(4, fourthValue),
    ];
    // update();
  }
}
