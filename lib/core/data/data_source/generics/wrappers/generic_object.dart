import 'package:labor_management_system/core/type_defs/create_response.dart';

import '../decoder/decoder.dart' show Decodable;

abstract class GenericObject<T>{

  GenericObject({required this.create});

  /// Create function instance for decoding JSON
  CreateResponse<Decodable> create;

  /// Decode JSON data into a generic object
  T genericObject(dynamic data) {
    final item = create();
    return item.decode(data);
  }

}