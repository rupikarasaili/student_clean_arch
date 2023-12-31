import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_clean_arch/features/batch/data/repository/batch_local_repo_impl.dart';

import '../../../../core/failure/failure.dart';
import '../entity/batch_entity.dart';

final batchRepositoryProvider = Provider<IBatchRepository>((ref){
  return ref.read(batchLocalRepoProvider);
});

abstract class IBatchRepository{
  Future<Either<Failure, List<BatchEntity>>> getAllBatches();
  Future<Either<Failure, bool>> addBatch(BatchEntity batch);
}