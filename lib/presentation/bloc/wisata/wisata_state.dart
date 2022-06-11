part of 'wisata_bloc.dart';

abstract class WisataState extends Equatable {
  const WisataState();

  List<Object> get props => [];
}

class WisataLoading extends WisataState {}

class WisataLoaded extends WisataState {
  final List<Wisata> wisata;

  WisataLoaded({this.wisata = const <Wisata>[]});

  List<Object> get props => [wisata];
}
