import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseChangeNotifierProvider<S extends ChangeNotifier>
    extends StatelessWidget {
  const BaseChangeNotifierProvider({
    super.key,
    required this.create,
    required this.builder,
  });

  final S Function(BuildContext context) create;
  final Widget Function(BuildContext context, S model) builder;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<S>(
      create: create,
      child: Consumer<S>(
        builder: (context, model, _) => builder(context, model),
      ),
    );
  }
}
