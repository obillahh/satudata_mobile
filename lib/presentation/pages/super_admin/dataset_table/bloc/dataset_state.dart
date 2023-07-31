// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dataset_bloc.dart';

@immutable
abstract class DatasetState extends Equatable {
  const DatasetState();

  @override
  List<Object?> get props => [];
}

class DatasetInitial extends DatasetState {}

class DatasetLoading extends DatasetState {}

class DatasetSuccess extends DatasetState {
  final List<ResponseDataset>? listDataset;
  final ResponseDataset? createDataset;
  final ResponseDataset? editDataset;

  const DatasetSuccess({
    this.listDataset,
    this.createDataset,
    this.editDataset,
  });

  @override
  List<Object?> get props => [
        listDataset,
        createDataset,
        editDataset,
      ];
}

class DatasetFail extends DatasetState {
  final String errorMessage;

  const DatasetFail({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
