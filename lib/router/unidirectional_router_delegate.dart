import 'package:flutter/material.dart';
import 'package:flutter_tools/extensions/nullability_extensions.dart';

@Deprecated('Use OnewayRouter instead.')
abstract class UnidirectionalRouterDelegate<ARS, PSA> extends RouterDelegate<ARS> with ChangeNotifier, PopNavigatorRouterDelegateMixin<ARS> {
  UnidirectionalRouterDelegate({required UnidirectionalRouterState<ARS, PSA> initialState}) :
        _stateToProcess = initialState,
        _initialState = initialState;

  final List<UnidirectionalRouterPage<ARS>> _stack = [];


  final UnidirectionalRouterState<ARS, PSA> _initialState;
  UnidirectionalRouterState<ARS, PSA>? _stateToProcess;

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  void reportRouterStateChanges(ARS appRouteState, [PSA? stateArguments]) {
    _stateToProcess = UnidirectionalRouterState(appRouteState, stateArguments);
    notifyListeners();
  }

  @override
  ARS get currentConfiguration {
    return tryOrNull(() => _stack.last).state ?? _initialState.state;
  }

  @override
  Widget build(BuildContext context) {
    if (_stateToProcess != null && _stateToProcess?.state != tryOrNull(() => _stack.last).state) {
      final willBeProcessingState = _stateToProcess;
      _stateToProcess = null;
      _stack.add(createNewPage(context, willBeProcessingState!));
    }

    late final pages = _stack.map((e) => e.page).toList();
    late final states = _stack.map((e) => e.page).toList();

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (states.length > 1) {
          _stack.removeLast();
        }

        notifyListeners();
        return true;
      },
    );
  }

  /// Once the Future completes, currentConfiguration will be pulled again, and it should be up to date.
  /// So navigational blocs should have required values already in the state.
  @override
  Future<void> setNewRoutePath(ARS configuration) async {
    reportRouterStateChanges(configuration);
  }

  UnidirectionalRouterPage<ARS> createNewPage(BuildContext context, UnidirectionalRouterState<ARS, PSA> stateToProcess);

}

class UnidirectionalRouterState<ARS, PSA> {
  UnidirectionalRouterState(this.state, this.arguments);

  final ARS state;
  final PSA? arguments;
}

class UnidirectionalRouterPage<ARS> {
  UnidirectionalRouterPage(this.state, this.page);

  final ARS state;
  final Page page;
}