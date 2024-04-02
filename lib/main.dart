import 'package:flutter/material.dart';
import 'package:flutter_playground/actions/actions.dart';
import 'package:flutter_playground/models/app_state.dart';
import 'package:flutter_playground/reducers/app_reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: const AppState(reduxSetup: false),
  );

  print('The initials state is: ${store.state}');

  runApp(StoreProvider(store: store, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playground',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Playground App'),
        ),
        body: StoreConnector<AppState, bool>(
          converter: (Store<AppState> store) => store.state.reduxSetup,
          builder: (BuildContext context, bool reduxSetup) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Redux is working: $reduxSetup'),
                  ElevatedButton(
                    child: Text('Dispatch the action'),
                    onPressed: () => StoreProvider.of<AppState>(context)
                        .dispatch(SomeAction(!reduxSetup)),
                  ),
                ],
              ),
            );
          },
      )
    ));
  }
}