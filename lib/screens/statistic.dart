import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Statistics",
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.background,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 📌 Header
                // Center(
                //   child: Text(
                //     "Your Quiz Performance",
                //     style: theme.textTheme.headlineSmall?.copyWith(
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20),

                // 📌 Summary Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _statsCard(theme, Icons.quiz, "Total Quizzes", "45"),
                    _statsCard(theme, Icons.trending_up, "Success Rate", "85%"),
                    _statsCard(theme, Icons.local_fire_department, "Streak", "10 Days"),
                  ],
                ),
                const SizedBox(height: 20),

                // 📊 Line Chart: Daily Quiz Attempts
                _sectionTitle("Daily Quiz Attempts", Icons.show_chart),
                _chartContainer(_lineChart(theme)),
                const SizedBox(height: 20),

                // 🥧 Pie Chart: Correct vs. Incorrect Answers
                _sectionTitle("Correct vs. Incorrect Answers", Icons.pie_chart),
                _chartContainer(_pieChart(theme)),
                const SizedBox(height: 20),

                // 📊 Bar Chart: Recent Quiz Scores
                _sectionTitle("Recent Quiz Scores", Icons.bar_chart),
                _chartContainer(_barChart(theme)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 📌 Summary Card Widget
  Widget _statsCard(ThemeData theme, IconData icon, String title, String value) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: theme.colorScheme.surface.withOpacity(0.9),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Prevents unwanted stretching
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: theme.colorScheme.primary,
                size: 36, // Slightly larger for better visibility
              ),
              const SizedBox(height: 10),
              // Title text
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface.withOpacity(0.8),
                    fontSize: 14,
                  ),
                  maxLines: 1, // Prevent text from overflowing
                  overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                ),
              ),
              const SizedBox(height: 6),
              // Value text
              Flexible(
                child: Text(
                  value,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                    fontSize: 20,
                  ),
                  maxLines: 1, // Prevent text from overflowing
                  overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 📌 Section Title with Icon
  Widget _sectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.white),
          const SizedBox(width: 8),
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }

  /// 📊 Chart Container
  Widget _chartContainer(Widget chart) {
    return SizedBox(
      height: 250,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        color: Colors.white.withOpacity(0.9),
        child: Padding(padding: const EdgeInsets.all(16.0), child: chart),
      ),
    );
  }

  /// 📈 Line Chart for Daily Quiz Attempts
  Widget _lineChart(ThemeData theme) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32, // Increased space to avoid text cutting
              getTitlesWidget: (value, meta) {
                List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
                if (value.toInt() < days.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      days[value.toInt()],
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40, // Extra spacing for clarity
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    "${value.toInt()} Q",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 2),
              FlSpot(1, 4),
              FlSpot(2, 3),
              FlSpot(3, 6),
              FlSpot(4, 5),
              FlSpot(5, 7),
              FlSpot(6, 4),
            ],
            isCurved: true,
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.blue.shade700],
            ),
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true, checkToShowDot: (spot, barData) => true),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.3),
                  Colors.blue.withOpacity(0.0),
                ],
                stops: [0.1, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🥧 Pie Chart for Correct vs. Incorrect Answers
  Widget _pieChart(ThemeData theme) {
    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            value: 75,
            title: "Correct",
            color: Colors.green,
            radius: 50,
            titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            value: 25,
            title: "Incorrect",
            color: Colors.red,
            radius: 50,
            titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  /// 📊 Bar Chart for Recent Quiz Scores
  Widget _barChart(ThemeData theme) {
    return BarChart(
      BarChartData(
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                return Text("${value.toInt()}%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold));
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                List<String> labels = ["Q1", "Q2", "Q3", "Q4", "Q5"];
                return Text(labels[value.toInt()], style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold));
              },
            ),
          ),
        ),
        barGroups: [
          _barData(0, 85, theme),
          _barData(1, 72, theme),
          _barData(2, 90, theme),
          _barData(3, 60, theme),
          _barData(4, 95, theme),
        ],
      ),
    );
  }

  /// 📊 Bar Chart Data
  BarChartGroupData _barData(int x, double y, ThemeData theme) {
    return BarChartGroupData(
      x: x,
      barRods: [BarChartRodData(toY: y, color: theme.colorScheme.primary, width: 16)],
    );
  }
}
