/// Decodable interface for parsing JSON data.
abstract class Decodable<T>{
  T decode(dynamic json);
}