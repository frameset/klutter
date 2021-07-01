part of 'book_screen_more_menu_cubit.dart';

abstract class BookScreenMoreMenuState extends Equatable {
  const BookScreenMoreMenuState();

  @override
  List<Object> get props => [];
}

class BookScreenMoreMenuInitial extends BookScreenMoreMenuState {}

class BookScreenMoreMenuAnalysisSuccessful extends BookScreenMoreMenuState {}

class BookScreenMoreMenuAnalysisFailed extends BookScreenMoreMenuState {}

class BookScreenMoreMenuRefreshSuccessful extends BookScreenMoreMenuState {}

class BookScreenMoreMenuRefreshFailed extends BookScreenMoreMenuState {}

class BookScreenMoreMenuMarkReadSuccess extends BookScreenMoreMenuState {}

class BookScreenMoreMenuMarkReadFailed extends BookScreenMoreMenuState {}

class BookScreenMoreMenuMarkUnreadSuccess extends BookScreenMoreMenuState {}

class BookScreenMoreMenuMarkUnreadFailed extends BookScreenMoreMenuState {}
