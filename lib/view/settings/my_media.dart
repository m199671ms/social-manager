import 'package:flutter/material.dart';
import 'package:social_manager/generated/l10n.dart';
import 'package:social_manager/models/service.dart';
import 'package:social_manager/models/user.dart';
import 'package:social_manager/utils/api_handler.dart';
import 'package:social_manager/utils/helper.dart';
import 'package:social_manager/utils/store.dart';

class MyMediaScreen extends StatefulWidget {
  const MyMediaScreen({Key? key}) : super(key: key);

  @override
  State<MyMediaScreen> createState() => _MyMediaScreenState();
}

class _MyMediaScreenState extends State<MyMediaScreen> {
  final List<MediaService> _enabled = [];
  late Future<List<MediaService>> _future;
  @override
  void initState() {
    super.initState();
    _enabled.addAll(Store.user!.services);
    _future = ApiHandler.mediaServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).my_media),
      ),
      body: FutureBuilder<List<MediaService>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasError &&
              snapshot.connectionState != ConnectionState.done) {
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
                        _future = ApiHandler.mediaServices();
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
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => SwitchListTile(
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Helper.mediaIcon(snapshot.data![index],
                                theme: IconThemeData(
                                  color: _enabled
                                          .contains(snapshot.data![index])
                                      ? snapshot.data![index].iconColor
                                      : Theme.of(context).unselectedWidgetColor,
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(snapshot.data![index].name),
                            ),
                          ],
                        ),
                        onChanged: (bool value) {
                          setState(() {
                            if (value) {
                              _enabled.add(snapshot.data![index]);
                            } else {
                              _enabled.remove(snapshot.data![index]);
                            }
                          });
                        },
                        activeColor: snapshot.data![index].iconColor,
                        selected: _enabled.contains(snapshot.data![index]),
                        value: _enabled.contains(snapshot.data![index]),
                      ),
                    ),
                  ),
                  ButtonBar(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          int limit = 2;
                          if (_enabled.length < limit) {
                            Helper.showError(
                                context: context,
                                subtitle: S
                                    .of(context)
                                    .you_should_enable_at_least_count_services_to_use_the_app(
                                        limit));
                            return;
                          }
                          Helper.doAsync<User>(
                            future: ApiHandler.setServices(
                              services: _enabled.map((e) => e.id).toList(),
                            ),
                            context: context,
                            onDone: (user) async {
                              Store.user = user;
                              await Future.delayed(
                                  const Duration(milliseconds: 100));
                              Navigator.of(context).pop(true);
                            },
                          );
                        },
                        icon: const Icon(Icons.save),
                        label: Text(
                          S.of(context).save,
                        ),
                      ),
                    ],
                  )
                ],
              );
          }
        },
      ),
    );
  }
}
