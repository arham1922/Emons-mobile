import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChart3DExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pie Chart 3D Example'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1, // 1:1 aspect ratio
          child: PieChart(
            PieChartData(
              sectionsSpace: 0, // Space between sections
              centerSpaceRadius: 40, // Radius of the center space
              sections: [
                PieChartSectionData(
                  value: 30,
                  color: const Color(0xFF61E540),
                  title: 'Slice 1',
                  radius: 30,
                ),
                PieChartSectionData(
                  value: 40,
                  color: const Color(0xFF3763FF),
                  title: 'Slice 2',
                  radius: 40,
                ),
                PieChartSectionData(
                  value: 10,
                  color: const Color(0xFFF2B53E),
                  title: 'Slice 3',
                  radius: 10,
                ),
                PieChartSectionData(
                  value: 20,
                  color: const Color(0xFFE03232),
                  title: 'Slice 4',
                  radius: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: PieChart3DExample()));
