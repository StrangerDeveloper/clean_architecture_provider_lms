

import 'package:flutter/material.dart';

/// A typedef for a map with `String` keys and `String` values.
typedef MapStringString = Map<String, String>;

/// A nullable typedef for a map with `String` keys and `String` values.
typedef MapStringStringNull = Map<String, String>?;
typedef MapStringNullString = Map<String, String?>;

/// A typedef for a map with `String` keys and dynamic values.
typedef MapStringDynamic = Map<String, dynamic>;

/// A nullable typedef for a map with `String` keys and dynamic values.
typedef MapStringDynamicNull = Map<String, dynamic>?;

/// A nullable typedef for a map with `String` keys and object values.
typedef MapStringObjectNull = Map<String, Object>?;

/// A typedef for a custom widget callback
typedef CustomWidgetCallBack = Widget Function();
