import 'package:beers_pairing/components/custom_widgets.dart';
import 'package:beers_pairing/models/beer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BeerDetailsScreen extends StatefulWidget {
  const BeerDetailsScreen({
    this.beer,
  });

  final Beer beer;

  @override
  _BeerDetailsScreenState createState() => _BeerDetailsScreenState();
}

class _BeerDetailsScreenState extends State<BeerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.beer.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                    tag: widget.beer.id,
                    child: CachedNetworkImage(
                      imageUrl: widget.beer.imageUrl ??
                          'https://via.placeholder.com/350?text=No+Image',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                widget.beer.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          AbvWidget(percentage: widget.beer.abv),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Text(
                        widget.beer.description,
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    Tagsline(
                      tagline: widget.beer.tagline.split(' '),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Food Pairings:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.beer.foodPairing
                                .map((food) => Text('- $food'))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    IngredientsPanel(
                      ingredients: widget.beer.ingredients,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IngredientsPanel extends StatefulWidget {
  const IngredientsPanel({
    Key key,
    @required this.ingredients,
  }) : super(key: key);

  final Ingredients ingredients;

  @override
  _IngredientsPanelState createState() => _IngredientsPanelState();
}

class _IngredientsPanelState extends State<IngredientsPanel> {
  bool pannelExpanded = false;
  bool maltExpanded = false;
  bool hopsExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expandedHeaderPadding: const EdgeInsets.all(0.0),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          pannelExpanded = !pannelExpanded;
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return const ListTile(
              title: Text(
                'Ingredientes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
          body: Column(
            children: <Widget>[
              ExpansionPanelList(
                expandedHeaderPadding: const EdgeInsets.all(0.0),
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: const Text('Malta'),
                        onTap: () {},
                      );
                    },
                    body: Container(),
                    isExpanded: false,
                  ),
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: const Text('Hops'),
                        onTap: () {},
                      );
                    },
                    body: Container(),
                    isExpanded: false,
                  ),
                ],
              ),
              ListTile(
                title: Text('Yeast: ${widget.ingredients.yeast}'),
                onTap: () {},
              ),
            ],
          ),
          isExpanded: pannelExpanded,
        )
      ],
    );
  }
}
