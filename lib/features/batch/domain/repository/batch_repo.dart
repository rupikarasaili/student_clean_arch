import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../entity/batch_entity.dart';

abstract class IBatchRepository{
  Future<Either<Failure, List<BatchEntity>>> getAllBatches();
  Future<Either<Failure, bool>> addBatch(BatchEntity batch);
}