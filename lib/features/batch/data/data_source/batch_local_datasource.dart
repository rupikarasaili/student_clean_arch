import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_clean_arch/features/batch/data/model/batch_hive_model.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/network/hive_service.dart';
import '../../domain/entity/batch_entity.dart';

final batchLocalDataSourceProvider = Provider<BatchLocalDataSource>((ref){
  return BatchLocalDataSource(
    hiveService: ref.read(hiveServiceProvider),
    batchHiveModel: ref.read(batchHiveModelProvider),
  );
});

class BatchLocalDataSource{
  final HiveService hiveService;
  final BatchHiveModel batchHiveModel;

  BatchLocalDataSource({
    required this.hiveService,
    required this.batchHiveModel,
  });

  //add batch
  Future<Either<Failure, bool>> addBatch(BatchEntity batch) async {
    try{
      //convert entity to hive object
      final hiveBatch = batchHiveModel.toHiveModel(batch);
      //add to hive
      await hiveService.addBatch(hiveBatch);
      return const Right(true);
    }catch(e){
      return Left(Failure(error: e.toString()));
    }
    }

    Future<Either<Failure, List<BatchEntity>>> getAllBatches() async{
      try{
        //gett all batches from hive
        final batches = await hiveService.getAllBatches();
        //convert hive object to entity
        final batchEntities = batchHiveModel.toEntityList(batches);
        return Right(batchEntities);

      }catch(e){
        return Left(Failure(error: e.toString()));
      }
    }
    
  }
