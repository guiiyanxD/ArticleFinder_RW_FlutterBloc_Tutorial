import 'package:article_finder/bloc/bloc.dart';
import 'package:flutter/material.dart';

//1
class BlocProvider<T extends Bloc> extends StatefulWidget{
  final Widget child;
  final T bloc;

  BlocProvider({
    Key? key, required this.bloc, required this.child
  }) : super(key: key);

  //2
  static T of<T extends Bloc>(BuildContext context){
    final BlocProvider<T> provider = context.findAncestorWidgetOfExactType()!;
    return provider.bloc;
  }
  @override
  State createState() {
    return _BlocProviderState();
  }
}
class _BlocProviderState extends State<BlocProvider>{
  //3
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
  //4
  @override
  void dispose(){
    widget.bloc.dispose();
    super.dispose();
  }

}
/**
 * In the code above:

    1. BlocProvider is a generic class. The generic type T is scoped to be an
      object that implements the Bloc interface. This means the provider can
      store only BLoC objects.

    2. The of method allows widgets to retrieve the BlocProvider from a
      descendant in the widget tree with the current build context. This is
      a common pattern in Flutter.

    3. The widget’s build method is a passthrough to the widget’s child.
      This widget won’t render anything.

    4. Finally, the only reason the provider inherits from StatefulWidget
      is to get access to the dispose method. When this widget is removed
      from the tree, Flutter calls the dispose method, which in turn
      closes the stream.
 */
