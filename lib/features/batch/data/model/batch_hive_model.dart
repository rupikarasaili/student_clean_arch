import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:student_clean_arch/config/constants/hive_table_constants.dart';

import 'package:uuid/uuid.dart';

import '../../domain/entity/batch_entity.dart';

part 'batch_hive_model.g.dart'; //dart run build_runner build --delete-conflicting-outputs

final batchHiveModelProvider = Provider(
  (ref)=> BatchHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.batchTableId)
class BatchHiveModel {
  @HiveField(0)
  final String batchId;
  @HiveField(1)
  final String batchName;

  BatchHiveModel.empty() : this(batchId: '', batchName: '');

  BatchHiveModel({
    String? batchId,
    required this.batchName,
  }) : batchId = batchId ?? const Uuid().v4();

  @override
  String toString() {
    return 'batchId: $batchId,batchName: $batchName';
  }

  // Convert Hive Object to Entity
  BatchEntity toEntity() => BatchEntity(batchId: batchId, batchName: batchName);

  // Convert Entity to Hive Object
  BatchHiveModel toHiveModel(BatchEntity entity) => BatchHiveModel(
      // batchId: entity.batchId,
      batchName: entity.batchName);

  // Convert Hive List to Entity List
  List<BatchEntity> toEntityList(List<BatchHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();
}
