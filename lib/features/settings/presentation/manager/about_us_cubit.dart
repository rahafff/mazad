import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';

import '../../../../core/global_states/standard_state.dart';
import '../../domain/entities/about_us_entity.dart';
import '../../domain/repositories/settings_repository.dart';

class AboutUsCubit extends Cubit<StandardState<AboutUsEntity>> {
  final SettingsRepository _settingsRepository;
  AboutUsCubit(this._settingsRepository) : super(const StandardState.loading());
  Future<void> emitGetAboutUs() async {
    emit(const StandardState.loading());
    final response = await _settingsRepository.getAboutUs();
    response.when(
      success: (BaseEntity<AboutUsEntity> entity) {
        if(!isClosed) {
          emit(
          StandardState.success(entity.data!),
        );
        }
      },
      failure: (NetworkExceptions failure) {
        emit(
          StandardState.error(failure),
        );
      },
    );
  }

  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text).documentElement!.text;

    return parsedString;
  }
}
