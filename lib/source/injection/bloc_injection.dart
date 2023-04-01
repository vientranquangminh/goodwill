
import 'package:goodwill/source/blocs/joke_cubit.dart';
import 'package:goodwill/source/data/api/api_client.dart';
import 'package:goodwill/source/injection/injector.dart';

class BlocInjection { 
  static void inject() {
    injector.registerLazySingleton<JokeCubit>(
      () => JokeCubit(
        injector.get<ApiClient>(),
      ),
    );
  }
}