import 'package:beers_pairing/bloc/provider.dart';
import 'package:beers_pairing/components/app_bars.dart';
import 'package:beers_pairing/localization/app_localization.dart';
import 'package:beers_pairing/screens/paired_beers.dart';
import 'package:beers_pairing/screens/random_beer.dart';
import 'package:flutter/material.dart';

class MainComponent extends StatefulWidget {
  @override
  _MainComponentState createState() => _MainComponentState();
}

class _MainComponentState extends State<MainComponent>
    with SingleTickerProviderStateMixin {
  ScrollController _appBarController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _appBarController = ScrollController();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging && _tabController.index == 1) {
        _appBarController.animateTo(MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      }
      if (_tabController.indexIsChanging && _tabController.index == 0) {
        _appBarController.animateTo(0.0,
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          controller: _appBarController,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            DefaultAppBar(
              title: BeersPairingLocalizations.of(context)
                  .translate(TranslationsKeys.appTitle),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    Provider.beersBlocOf(context).getRandomBeer();
                  },
                ),
              ],
            ),
            const AppBarPairedBeersBody(),
          ],
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return Column(
            children: <Widget>[
              TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    child: Text(BeersPairingLocalizations.of(context)
                        .translate(TranslationsKeys.randomBeerTabTitle)),
                  ),
                  Tab(
                    child: Text(BeersPairingLocalizations.of(context)
                        .translate(TranslationsKeys.pairedBeersTabTitle)),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    RandomBeerBody(
                      orientation: orientation,
                    ),
                    PairedBeersBody(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
