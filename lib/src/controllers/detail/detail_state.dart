import 'package:meta/meta.dart';

@immutable
class DetailState {
  final bool isLoading;
  final Map detailInfo;

  DetailState({
    @required this.isLoading,
    @required this.detailInfo,
  });

  factory DetailState.empty() {
    return DetailState(
      isLoading: true,
      detailInfo: null,
    );
  }

  factory DetailState.update(detailInfo) {
    return DetailState(
      isLoading: false,
      detailInfo: detailInfo
    );
  }

  factory DetailState.failure() {
    return DetailState(
      isLoading: false,
      detailInfo: null
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isLoading: $isLoading,
      detailInfo: $detailInfo,
    }''';
  }
}
