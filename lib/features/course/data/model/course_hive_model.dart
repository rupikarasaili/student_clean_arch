import 'package:hive/hive.dart';
import 'package:student_clean_arch/config/constants/hive_table_constants.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entity/course_entity.dart';
part 'course_hive_model.g.dart'; //dart run build_runner build --delete-conflicting-outputs


@HiveType(typeId: HiveTableConstant.courseTableId)
class CourseHiveModel {
  @HiveField(0)
  final String courseId;
  @HiveField(1)
  final String courseName;

  CourseHiveModel.empty() : this(courseId: '', courseName: '');

  CourseHiveModel({
    String? courseId,
    required this.courseName,
  }) : courseId = courseId ?? const Uuid().v4();

  @override
  String toString() {
    return 'courseId: $courseId,courseName: $courseName';
  }
  
  // Convert Hive Object to Entity
  CourseEntity toEntity() => CourseEntity(courseId: courseId, courseName: courseName);

  // Convert Entity to Hive Object
  CourseHiveModel toHiveModel(CourseEntity entity) => CourseHiveModel(
      // batchId: entity.batchId,
      courseName: entity.courseName);
  List<CourseHiveModel> toHiveModelList(List<CourseEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();
  // Convert Hive List to Entity List
  List<CourseEntity> toEntityList(List<CourseHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();
}
