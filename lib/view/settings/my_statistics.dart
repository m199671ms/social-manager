import 'package:charts_painter/chart.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:social_manager/generated/l10n.dart';
import 'package:social_manager/models/service_media_statistics.dart';
import 'package:social_manager/utils/api_handler.dart';
import 'package:social_manager/utils/helper.dart';

class MyStatistics extends StatefulWidget {
  const MyStatistics({Key? key}) : super(key: key);

  @override
  State<MyStatistics> createState() => _MyStatisticsState();
}

class _MyStatisticsState extends State<MyStatistics> {
  late Future<List<ServiceMediaStatistics>> _future;
  bool _includeSaved = false;
  @override
  void initState() {
    _future = ApiHandler.statistics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).my_statistics),
          bottom: TabBar(
            tabs: [
              Tab(
                text: S.of(context).bar_charts,
              ),
              Tab(
                text: S.of(context).pie_charts,
              )
            ],
          ),
        ),
        body: FutureBuilder<List<ServiceMediaStatistics>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasError && snapshot.data != null) {
              return SizedBox.expand(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).connection_error,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 32.0),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.error,
                      ),
                      onPressed: () {
                        setState(() {
                          _future = ApiHandler.statistics();
                        });
                      },
                      icon: const Icon(Icons.refresh),
                      label: Text(S.of(context).retry),
                    ),
                  ],
                ),
              );
            }

            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SwitchListTile(
                      title: Text(S.of(context).include_saved_links),
                      subtitle: Text(S
                          .of(context)
                          .the_saved_links_may_show_certain_behaviour_of_which_platform_you_find_more_informing),
                      value: _includeSaved,
                      onChanged: (value) {
                        setState(() {
                          _includeSaved = value;
                        });
                      },
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _BarChart(
                            statuses: snapshot.data!,
                            includeSaved: _includeSaved,
                          ),
                          _PieChart(
                            statistics: snapshot.data!,
                            includeSaved: _includeSaved,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        S.of(context).legend + ' :',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) =>
                          ListTile(
                        leading: SizedBox.square(
                          dimension: 40,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: snapshot.data![index].media.iconColor
                                  .withAlpha(20),
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: snapshot.data![index].media.iconColor,
                                width: 2.0,
                              ),
                            ),
                            child: Center(
                              child:
                                  Helper.mediaIcon(snapshot.data![index].media),
                            ),
                          ),
                        ),
                        title: Text(snapshot.data![index].media.name),
                        subtitle: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: S.of(context).links_opened +
                                    ' : ' +
                                    snapshot.data![index].count.toString() +
                                    '.',
                              ),
                              const TextSpan(text: ' | '),
                              TextSpan(
                                text: S.of(context).links_saved +
                                    ' : ' +
                                    snapshot.data![index].saved.toString() +
                                    '.',
                              ),
                            ],
                          ),
                        ),
                      ),
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  final List<ServiceMediaStatistics> statuses;
  final bool includeSaved;
  const _BarChart({
    Key? key,
    required this.statuses,
    required this.includeSaved,
  }) : super(key: key);
  int itemCount(ServiceMediaStatistics item) =>
      item.count + (includeSaved ? item.saved : 0);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: AnimatedChart<ServiceMediaStatistics>(
        duration: const Duration(milliseconds: 700),
        curve: Curves.ease,
        width: 10,
        state: ChartState.bar(
          ChartData<ServiceMediaStatistics>.fromList(
            statuses
                .map(
                  (e) => ChartItem<ServiceMediaStatistics>(
                    e,
                    0.0,
                    itemCount(e).toDouble(),
                  ),
                )
                .toList(),
          ),
          itemOptions: BarItemOptions(
            radius: const BorderRadius.vertical(
              top: Radius.circular(25),
            ),
            colorForKey: (item, _) =>
                (item.value as ServiceMediaStatistics).media.iconColor,
            padding: const EdgeInsets.all(16.0),
            multiValuePadding: const EdgeInsets.all(16.0),
          ),
          behaviour: const ChartBehaviour(
            isScrollable: false,
          ),
          backgroundDecorations: [
            GridDecoration(
              verticalAxisStep: 10,
              horizontalAxisStep: 10,
              showHorizontalValues: true,
              textStyle: const TextStyle(fontSize: 15),
              // horizontalAxisUnit: 'link',
            ),
          ],
        ),
      ),
    );
  }
}

class _PieChart extends StatefulWidget {
  final List<ServiceMediaStatistics> statistics;
  final bool includeSaved;
  const _PieChart({
    Key? key,
    required this.statistics,
    required this.includeSaved,
  }) : super(key: key);

  @override
  State<_PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<_PieChart>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animationView;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
      reverseDuration: const Duration(milliseconds: 700),
    );
    _animationView = Tween<double>(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(_animationController)
      ..addListener(() {});
    _animationController.value = widget.includeSaved ? 1 : 0;
  }

  int itemCount(ServiceMediaStatistics item) =>
      item.count +
      (widget.includeSaved
          ? (_animationController.value * item.saved).toInt()
          : 0);

  @override
  void didUpdateWidget(_PieChart oldWidget) {
    if (widget.includeSaved) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
      animation: _animationView,
      builder: (_, __) {
        int all = 0;
        for (var item in widget.statistics) {
          all += itemCount(item);
        }
        return PieChart(
          dataMap: Map<String, double>.fromEntries(
            widget.statistics.map(
              (e) => MapEntry<String, double>(
                e.media.name,
                (itemCount(e).toDouble() / all.toDouble()) * 100,
              ),
            ),
          ),
          animationDuration: const Duration(milliseconds: 700),
          chartRadius: MediaQuery.of(context).size.width / 1.5,
          colorList: widget.statistics.map((e) => e.media.iconColor).toList(),
          initialAngleInDegree: 0,
          chartType: ChartType.disc,
          ringStrokeWidth: 100,
          legendOptions: const LegendOptions(showLegends: false),
          emptyColor: Colors.black,
          chartValuesOptions: const ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: true,
            showChartValuesInPercentage: false,
            showChartValuesOutside: false,
            decimalPlaces: 2,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
