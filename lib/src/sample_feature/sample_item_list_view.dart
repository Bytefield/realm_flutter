import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:realm/realm.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';

class ListBloc {
  final RealmResults<SampleItem> items;
  final Realm _realm;
  ListBloc(this.items) : _realm = items.realm;

  void addNewItem() {
    _realm.write(() => _realm.add(SampleItem(1 + (items.lastOrNull?.id ?? 1))));
  }
}

class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    required this.bloc,
  });

  static const routeName = '/';
  final ListBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream: bloc.items.changes,
          builder: (context, snapshot) {
            return ListView.builder(
              // Providing a restorationId allows the ListView to restore the
              // scroll position when a user leaves and returns to the app after it
              // has been killed while running in the background.
              restorationId: 'sampleItemListView',
              itemCount: bloc.items.length,
              itemBuilder: (context, int index) {
                final item = bloc.items[index];

                return SampleItemTile(bloc: ItemBloc(item));
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: bloc.addNewItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemBloc {
  final SampleItem item;
  final Realm _realm;
  ItemBloc(this.item) : _realm = item.realm;

  void deleteItem() {
    _realm.write(() => _realm.delete(item));
  }
}

class SampleItemTile extends StatelessWidget {
  const SampleItemTile({
    super.key,
    required this.bloc,
  });

  final ItemBloc bloc;

  @override
  Widget build(context) {
    final item = bloc.item;
    return Dismissible(
      key: ValueKey(item.id),
      background: Container(color: Colors.red),
      onDismissed: (direction) => bloc.deleteItem(),
      child: ListTile(
        title: Text('SampleItem ${item.id}'),
        leading: const CircleAvatar(
          // Display the Flutter Logo image asset.
          foregroundImage: AssetImage('assets/images/flutter_logo.png'),
        ),
        onTap: () {
          // Navigate to the details page. If the user leaves and returns to
          // the app after it has been killed while running in the
          // background, the navigation stack is restored.
          Navigator.restorablePushNamed(
            context,
            SampleItemDetailsView.routeName,
          );
        },
      ),
    );
  }
}
