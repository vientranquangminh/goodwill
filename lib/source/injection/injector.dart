import 'package:get_it/get_it.dart';
import 'package:goodwill/source/injection/bloc_injection.dart';
import 'package:goodwill/source/injection/infra_injection.dart';


GetIt injector = GetIt.instance;

Future<void> initDependenciesInjection() async {
  // infra
  InfraInjection.inject();

  // bloc
  BlocInjection.inject();
}
