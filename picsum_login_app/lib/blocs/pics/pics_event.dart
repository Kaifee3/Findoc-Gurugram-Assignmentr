import 'package:equatable/equatable.dart';

abstract class PicsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPics extends PicsEvent {
  final int limit;
  FetchPics({this.limit = 10});
  @override
  List<Object?> get props => [limit];
}
