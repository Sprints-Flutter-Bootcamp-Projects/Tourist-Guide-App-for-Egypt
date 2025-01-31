import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide/blocs/places/places_bloc.dart';
import 'package:tourist_guide/models/place_model.dart';
import 'package:tourist_guide/app_drawer.dart';
import 'package:tourist_guide/utils/widgets/grid_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlacesBloc>(context).add(LoadPlaces());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: Text(context.tr("welcome"))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<PlacesBloc, PlacesState>(
          listener: (context, state) {
            if (state is PlacesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  duration: const Duration(seconds: 5),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is PlacesLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PlacesLoaded) {
              final List<Place> suggestedPlaces = state.suggestedPlaces;
              final List<Place> popularPlaces = state.popularPlaces;
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Text(
                          tr("suggested_places"),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ]),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return GridItem(place: suggestedPlaces[index]);
                        },
                        childCount: suggestedPlaces.length,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const Divider(),
                        Text(
                          tr("popular_places"),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ]),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    sliver: SliverToBoxAdapter(
                      child: SizedBox(
                        height: 200.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: popularPlaces.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GridItem(place: popularPlaces[index]),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<PlacesBloc>(context)
                              .add(LoadMorePlaces());
                        },
                        child: Text(
                          tr("load_more"),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
