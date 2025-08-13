import 'package:equatable/equatable.dart';
import '../../models/picture.dart';

abstract class PicsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PicsInitial extends PicsState {}

class PicsLoadInProgress extends PicsState {}

class PicsLoadSuccess extends PicsState {
  final List<Picture> pics;
  PicsLoadSuccess(this.pics);
  @override
  List<Object?> get props => [pics];
}

class PicsLoadFailure extends PicsState {
  final String message;
  PicsLoadFailure(this.message);
  @override
  List<Object?> get props => [message];
}
