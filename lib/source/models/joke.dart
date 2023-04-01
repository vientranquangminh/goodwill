// To parse this JSON data, do
//
//     final joke = jokeFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'joke.freezed.dart';
part 'joke.g.dart';

@freezed
abstract class Joke with _$Joke {
  const factory Joke({
    bool? error,
    String? category,
    String? type,
    String? joke,
    Flags? flags,
    int? id,
    bool? safe,
    String? lang,
  }) = _Joke;

  factory Joke.fromJson(Map<String, dynamic> json) => _$JokeFromJson(json);
}

@freezed
abstract class Flags with _$Flags {
  const factory Flags({
    bool? nsfw,
    bool? religious,
    bool? political,
    bool? racist,
    bool? sexist,
    bool? explicit,
  }) = _Flags;

  factory Flags.fromJson(Map<String, dynamic> json) => _$FlagsFromJson(json);
}
