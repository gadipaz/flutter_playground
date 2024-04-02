
import 'package:flutter_playground/models/app_state.dart';
import 'package:flutter_playground/reducers/sample_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    reduxSetup: sampleReducer(state.reduxSetup, action),
  );
}