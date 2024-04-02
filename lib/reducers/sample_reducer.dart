import 'package:redux/redux.dart';
import 'package:flutter_playground/actions/actions.dart';

final sampleReducer = TypedReducer<bool, SomeAction>(_sampleActionReducer);

bool _sampleActionReducer(bool state, SomeAction action) {
  return action.somePayload;
}