import 'package:provider/provider.dart';
import 'package:first_flutter_app/data/local/to_do_item_provider.dart';
import 'package:provider/single_child_widget.dart';


List<SingleChildWidget> providers = <SingleChildWidget>[
  Provider<ToDoItemProvider>(create: (_) => ToDoItemProvider()),
];