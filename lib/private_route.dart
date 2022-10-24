// import 'dart:collection';
// import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';

// class ConditionalRouter extends MapMixin<String, WidgetBuilder> {
//   final Map<String, WidgetBuilder> public;
//   final Map<String, WidgetBuilder> private;

//   ConditionalRouter({required this.public, required this.private});

//   final isAuth=Consumer(builder:(context, auth, child) => ,)

//   WidgetBuilder operator (Object key) {
    
//     if (public.containsKey(key)) return public[key];
//     if (private.containsKey(key)) {
//       if (MyAuth.isUserLoggedIn) return private[key];
//       // Adding next page parameter to your Login page
//       // will allow you to go back to page, that user were going to
//       return (context) => LoginPage(nextPage: key);
//     }
//   }

//   @override
//   void operator []=(key, value) {}

//   @override
//   void clear() {}

//   @override
//   Iterable<String> get keys {
//     final set = Set<String>();
//     set.addAll(public.keys);
//     set.addAll(private.keys);
//     return set;
//   }

//   @override
//   WidgetBuilder remove(Object key) {
//     return public[key] ?? private[key];
//   }
// }
