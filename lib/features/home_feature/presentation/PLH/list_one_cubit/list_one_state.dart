part of 'list_one_cubit.dart';

sealed class ListOneState extends Equatable {
  const ListOneState();
}

final class ListOneInitial extends ListOneState {
  @override
  List<Object> get props => [];
}

final class ListOneLoading extends ListOneState {
  @override
  List<Object> get props => [];
}
