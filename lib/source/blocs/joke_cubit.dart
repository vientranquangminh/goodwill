import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:goodwill/source/data/api/api_client.dart';
import 'package:goodwill/source/enum/loading_status.dart';
import 'package:goodwill/source/models/joke.dart';

part 'joke_cubit.freezed.dart';
part 'joke_state.dart';

class JokeCubit extends Cubit<JokeState> {
  JokeCubit(this._apiClient, {JokeState? initial})
      : super(initial ?? JokeState(loadingStatus: LoadingStatus.initial));
  final ApiClient _apiClient;

  Future<Joke?> getJoke(String category) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.initial));
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final response = await _apiClient.getJokes(category);
      emit(
          state.copyWith(joke: response, loadingStatus: LoadingStatus.success));
      return response;
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.failed));
      return null;
    }
  }
}
