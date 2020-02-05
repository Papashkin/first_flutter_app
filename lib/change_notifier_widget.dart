import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeNotifierWidget<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierWidget({
    Key key,
    @required this.viewModel,
    @required this.builder,
    this.child,
    this.onInitWidget,
  }) : super(key: key);

  final Function(BuildContext context, T viewModel, Widget child) builder;
  final T viewModel;
  final Widget child;
  final Function(T) onInitWidget;

  @override
  _ChangeNotifierWidgetState<T> createState() =>
      _ChangeNotifierWidgetState<T>();
}

class _ChangeNotifierWidgetState<T extends ChangeNotifier>
    extends State<ChangeNotifierWidget<T>> {
  T viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
    if (viewModel != null) {
      widget.onInitWidget(viewModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => viewModel,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
