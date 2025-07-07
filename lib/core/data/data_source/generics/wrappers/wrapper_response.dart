import 'package:labor_management_system/core/data/data_source/generics/wrappers/generic_object.dart';

class ResponseWrapper<T> extends GenericObject<T>{
  /// Constructs a [ResponseWrapper] with the given [create] function and optional [error].
  ResponseWrapper({required super.create});
  /// The data of the response, which can be of any type [T].
  T? data;

  /// The error response, if any.
  //ErrorResponse? error;

}