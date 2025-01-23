import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/data/gov_data.dart';
import 'package:tourist_guide/navigation/app_drawer.dart';
import '../../widgets/governorate_list_tile.dart';
import 'landmark_page.dart';

class GovernmentPage extends StatelessWidget {
  const GovernmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext _) => const GovernmentListPage();
            break;
          case '/landmark':
            final args = settings.arguments as Map<String, dynamic>;
            builder = (BuildContext _) => LandmarkPage(
                  governorateName: args['governorateName'],
                  landmarks: args['landmarks'],
                );
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class GovernmentListPage extends StatelessWidget {
  const GovernmentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(tr('government')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              tr('governorates'),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.teal[800],
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 8);
                },
                itemCount: govData.length,
                itemBuilder: (BuildContext context, int index) {
                  return GovernorateListTile(
                    goverorateName: tr(govData[index]['governorate']),
                    onTap: () {
                      Navigator.pushNamed(context, '/landmark', arguments: {
                        'governorateName': govData[index]['governorate'],
                        'landmarks': govData[index]['landmarks'],
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
