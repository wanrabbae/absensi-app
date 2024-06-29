import 'package:app/data/models/report/report.dart';
import 'package:app/global_resource.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'report_state.dart';

part 'report_cubit.freezed.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit({
    required XFile image,
    required ReportType type,
  }) : super(ReportState(image: image, type: type));

  final descriptionTextController = TextEditingController();
}
