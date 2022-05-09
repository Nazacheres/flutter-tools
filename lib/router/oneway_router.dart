import 'package:flutter/material.dart';
import 'package:flutter_tools/extensions/nullability_extensions.dart';

abstract class OnewayRouter<ARS, PSA> extends RouterDelegate<ARS> with ChangeNotifier, PopNavigatorRouterDelegateMixin<ARS> {
  OnewayRouter({required this.logListener, required OnewayRouterState<ARS, PSA> initialState}) : _initialState = initialState;

  final OnewayCallback logListener;
  final List<OnewayRouterPage<ARS>> _stack = [];
  final OnewayRouterState<ARS, PSA> _initialState;

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  Page pickNewPageOrRepeat(bool keepPageIfSame, Page? lastPage, Page newPage) {
    if (lastPage == null) {
      return newPage;
    } else if (keepPageIfSame && newPage.name == lastPage.name) {
      return lastPage;
    } else {
      return newPage;
    }
  }

  void reportRouterStateChanges(ARS appRouteState, {PSA? stateArguments, bool isDeepLink = false}) {
    logListener('UniRouter - Received ARS: $appRouteState with PDS: $stateArguments');

    final stateToProcess = OnewayRouterState(appRouteState, stateArguments);

    if (stateToProcess.state != tryOrNull(() => _stack.last)?.state) {
      final _newStack = updateStack(stateToProcess, _stack.toList(), isDeepLink);
      _stack.clear();
      _stack.addAll(_newStack);
    }

    notifyListeners();
  }

  @override
  ARS get currentConfiguration {
    return tryOrNull(() => _stack.last)?.state ?? _initialState.state;
  }

  @override
  Widget build(BuildContext context) {
    if (_stack.isEmpty) {
      final _newStack = updateStack(_initialState, _stack.toList(), false);
      _stack.clear();
      _stack.addAll(_newStack);
    }

    late final pages = _stack.map((e) => e.page).toList();
    late final states = _stack.map((e) => e.state).toList();

    logListener('UniRouter - building stack of pages ${pages.map((e) => e.name).join(', ')} with stack of state ${states.join(', ')}');

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
    reportRouterStateChanges(configuration, isDeepLink: true);
  }

  List<OnewayRouterPage<ARS>> updateStack(OnewayRouterState<ARS, PSA> stateToProcess, List<OnewayRouterPage<ARS>> currentStack, bool isDeepLink);
}

class OnewayRouterState<ARS, PSA> {
  OnewayRouterState(this.state, this.arguments);

  final ARS state;
  final PSA? arguments;
}

class OnewayRouterPage<ARS> {
  OnewayRouterPage(this.state, this.page);

  final ARS state;
  final Page page;
}

typedef OnewayCallback = void Function(String);
