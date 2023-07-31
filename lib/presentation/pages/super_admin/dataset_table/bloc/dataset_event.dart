part of 'dataset_bloc.dart';

@immutable
abstract class DatasetEvent extends Equatable {
  const DatasetEvent();

  @override
  List<Object?> get props => [];
}

class FetchDatasets extends DatasetEvent {}

class FetchDatasetsWithToken extends DatasetEvent {}

class CreateDataset extends DatasetEvent {
  final ResponseDataset createDataset;

  const CreateDataset({required this.createDataset});

  @override
  List<Object?> get props => [createDataset];
}
class EditDataset extends DatasetEvent {
  final ResponseDataset editDataset;

  const EditDataset({required this.editDataset});

  @override
  List<Object?> get props => [editDataset];
}
