import 'package:bill_maker/utilis/colors.dart';
import 'package:bill_maker/utilis/fonts.dart';
import 'package:coustom_flutter_widgets/datepicker.dart';
import 'package:coustom_flutter_widgets/size_extensiton.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends StatefulWidget {
  const BarChart({super.key});

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  @override
  Widget build(BuildContext context) {
    TextEditingController toDate = TextEditingController();
    TextEditingController fromDate = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors().alternate,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bar Chart",
                style: AppStyle().title.copyWith(
                      color: AppColors().primaryText,
                    ),
              ),
              20.ph,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 700,
                        child: SfCartesianChart(
                          primaryXAxis: const CategoryAxis(),
                          series: <CartesianSeries>[
                            LineSeries<ChartData, String>(
                              dataSource: [
                                ChartData('Jan', 35, Colors.red),
                                ChartData('Feb', 20, Colors.green),
                                ChartData('Mar', 34, Colors.blue),
                                ChartData('Apr', 32, Colors.pink),
                                ChartData('May', 40, Colors.black)
                              ],
                              color: AppColors().primary,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                            ),
                          ],
                        ),
                      ),
                      40.ph,
                      CoustomDatePicker(
                        controller: toDate,
                      ),
                      10.ph,
                      CoustomDatePicker(
                        controller: fromDate,
                      ),
                      15.ph,
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors().secondaryText,
                          ),
                          child: Center(
                            child: Text(
                              "Show",
                              style: AppStyle().normal,
                            ),
                          ),
                        ),
                      ),
                      20.ph,
                    ], // page end
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
