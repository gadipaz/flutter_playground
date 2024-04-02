import 'package:flutter/material.dart';
import 'package:flutter_playground/actions/actions.dart';
import 'package:flutter_playground/models/app_state.dart';
import 'package:flutter_playground/reducers/app_reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qr_flutter_new/qr_flutter.dart';
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
        //brightness: Brightness.dark,
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
                  QrImageView(
                    data: 'https://www.ynet.co.il',
                    version: QrVersions.auto,
                    foregroundColor: Colors.blue,
                    size: 320,                    
                    eyeStyle: const QrEyeStyle(borderRadius: 10),
                    // dataModuleStyle: const QrDataModuleStyle(
                    //   borderRadius: 5,
                    //   roundedOutsideCorners: true,
                    // ),
                    embeddedImage: const AssetImage('assets/images/bird.png'),
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: Size.square(60),
                      shapeColor: Colors.white,
                      safeArea: true,
                      // safeAreaMultiplier: 1.05,
                      embeddedImageShape: EmbeddedImageShape.square,
                      borderRadius: 10,
                    ),
                  ),
                ],
              ),
            );
          },
      )
    ));
  }
}