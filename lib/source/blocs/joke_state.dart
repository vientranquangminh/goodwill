part of 'joke_cubit.dart';

@freezed
class JokeState with _$JokeState {
  factory JokeState({
    Joke? joke,
    LoadingStatus? loadingStatus,
  }) = _JokeState;

  factory JokeState.initial() => JokeState(loadingStatus: LoadingStatus.initial);
}