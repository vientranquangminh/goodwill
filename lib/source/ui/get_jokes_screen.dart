import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/blocs/joke_cubit.dart';
import 'package:goodwill/source/common/widgets/app_bar/custom_app_bar.dart';
import 'package:goodwill/source/common/widgets/loading/fetching_screen.dart';
import 'package:goodwill/source/enum/loading_status.dart';
import 'package:goodwill/source/injection/injector.dart';

class GetJokesScreen extends StatefulWidget {
  const GetJokesScreen({super.key});

  @override
  State<GetJokesScreen> createState() => _GetJokesScreenState();
}

class _GetJokesScreenState extends State<GetJokesScreen> {
  final JokeCubit _jokeCubit = injector.get<JokeCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _jokeCubit.getJoke('programming');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorName.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: appLocalizations?.getJokesScreen ?? '',
      ),
      body: BlocBuilder(
        bloc: _jokeCubit,
        builder: (BuildContext context, JokeState state) {
          log((state.loadingStatus == LoadingStatus.success).toString());
          return state.loadingStatus != LoadingStatus.success
              ? const FetchingOverlay()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text(state.joke?.joke ?? 'empty'),
                  ),
                );
        },
      ),
    );
  }
}
