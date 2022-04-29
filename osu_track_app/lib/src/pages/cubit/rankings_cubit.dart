import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../requests/requests.dart';
import '../../utils/secure_storage.dart';
import '../../models/rankings.dart';

part 'rankings_state.dart';

class RankingsCubit extends Cubit<RankingsState> {
  RankingsCubit() : super(RankingsInitial("all", false, "1"));

  Future<void> informInitial() async {
    print('RankingsPage loading');
  }

  Future<void> loadRankings(filter, filterFriendsValue, page, mode) async {
    if (filterFriendsValue == true) {filter = "friends";};
    if (filterFriendsValue == false) {filter = "all";};
    try {
      emit(RankingsLoadedState(await getRankings(
          (await UserSecureStorage.getTokenFromStorage())!, page, filter, mode),
          filter,
          filterFriendsValue,
          page));
      print('Rankings loaded');
    } catch (e) {
      emit(RankingsErrorState('Failed Rankings Load $e'));
    }
  }

  Future<void> reloadRankings(filter, filterFriendsValue, page, mode) async {
    emit(RankingsInitial(filter, filterFriendsValue, page));
  }

}