import 'package:core/tv/domain/usecases/get_tv_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_object.dart';

void main() {
  late GetTvDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvDetail(mockTvRepository);
  });

  final tId = 1399;
  test("seharusnya mendapatkan tv detail dari repository", () async {
    //arrange
    when(mockTvRepository.getTvDetail(tId))
        .thenAnswer((_) async => Right(testTvDetail));

    //act
    final result = await usecase.execute(tId);
    //assert
    expect(result, Right(testTvDetail));
  });
}
