import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pesona_indonesiaku_app/data/models/wisata_model.dart';
import 'package:pesona_indonesiaku_app/data/repository/wisata_repository.dart';

part 'wisata_state.dart';
part 'wisata_event.dart';

class WisataBloc extends Bloc<WisataEvent, WisataState> {
  final WisataRepository _wisataRepository;
  StreamSubscription? _wisataSubscription;

  WisataBloc({required WisataRepository wisataRepository})
      : _wisataRepository = wisataRepository,
        super(WisataLoading()) {
    on<LoadWisata>((event, emit) {
      _wisataSubscription?.cancel();
      _wisataSubscription = _wisataRepository.getAllWisata().listen(
            (products) => add(
              UpdateWisata(products),
            ),
          );
    });
    on<UpdateWisata>((event, emit) {
      emit(
        WisataLoaded(wisata: event.wisata),
      );
    });
  }
}
