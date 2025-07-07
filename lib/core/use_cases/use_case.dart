/// A class to represent a use case.
/// Use cases are the building blocks of the app.
abstract class UseCase<Type, Params> {
  /// Creates a [UseCase] with the given [params].
  Future<Type> call({Params params});
}
