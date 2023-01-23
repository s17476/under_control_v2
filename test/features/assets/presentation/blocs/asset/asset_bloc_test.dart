import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/domain/entities/assets_stream.dart';
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream.dart';
import 'package:under_control_v2/features/assets/presentation/blocs/asset/asset_bloc.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart';

class MockFilterBloc extends Mock implements Stream<FilterState>, FilterBloc {}

class MockGetAssetsStream extends Mock implements GetAssetsStream {}

class MockAuthenticationBloc extends Mock
    implements Stream<AuthenticationState>, AuthenticationBloc {}

void main() {
  late MockAuthenticationBloc mockAuthenticationBloc;
  late MockFilterBloc mockFilterBloc;

  late MockGetAssetsStream mockGetAssetsStream;

  late AssetBloc assetBloc;

  setUp(() {
    mockAuthenticationBloc = MockAuthenticationBloc();
    mockFilterBloc = MockFilterBloc();

    when(() => mockAuthenticationBloc.stream).thenAnswer(
      (_) => Stream.fromFuture(
        Future.value(EmptyAuthenticationState()),
      ),
    );

    when(() => mockFilterBloc.stream).thenAnswer(
      (_) => Stream.fromFuture(
        Future.value(
          FilterEmptyState(),
        ),
      ),
    );
    when(() => mockFilterBloc.state).thenAnswer(
      (_) => FilterEmptyState(),
    );

    mockGetAssetsStream = MockGetAssetsStream();
    assetBloc = AssetBloc(
      authenticationBloc: mockAuthenticationBloc,
      filterBloc: mockFilterBloc,
      getAssetsStream: mockGetAssetsStream,
    );
  });

  setUpAll(() {
    registerFallbackValue(
      const AssetsInLocationsParams(
        locations: ['loc1', 'loc2'],
        companyId: 'companyId',
      ),
    );
  });

  group('Asset BLoC', () {
    test(
      'should emit [AssetEmptyState] as an initial state',
      () async {
        // assert
        expect(assetBloc.state, AssetEmptyState());
      },
    );

    group('GetAssetsStream', () {
      blocTest<AssetBloc, AssetState>(
        'should emit [AssetLoadedState] when GetAssetsStream is called',
        build: () => assetBloc,
        act: (bloc) async {
          bloc.add(GetAssetsStreamEvent());
          when(() => mockGetAssetsStream(any())).thenAnswer(
            (_) async => Right(
              AssetsStream(
                allAssets: Stream.fromIterable([]),
              ),
            ),
          );
        },
        expect: () => [isA<AssetLoadedState>()],
      );
    });
  });
}
