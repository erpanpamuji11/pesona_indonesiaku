part of 'wisata_bloc.dart';

abstract class WisataEvent extends Equatable {
  const WisataEvent();

  List<Object> get props => [];
}

class LoadWisata extends WisataEvent {}

class UpdateWisata extends WisataEvent {
  final List<Wisata> wisata;

  UpdateWisata(this.wisata);

  List<Object> get props => [wisata];
}
