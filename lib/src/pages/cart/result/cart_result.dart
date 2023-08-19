import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_result.freezed.dart';

@freezed
class CartResult<T> with _$CartResult<T> {
  factory CartResult.success(T data) = success;
  factory CartResult.error(String message) = Error;
}
