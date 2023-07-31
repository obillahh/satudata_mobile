import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:satudata_mobile/data/models/dataset/response_dataset.dart';
import 'package:satudata_mobile/data/request/api_dataset.dart';

part 'dataset_event.dart';
part 'dataset_state.dart';

class DatasetBloc extends Bloc<DatasetEvent, DatasetState> {
  DatasetBloc() : super(DatasetInitial()) {
    on<FetchDatasets>((event, emit) async {
      emit(DatasetLoading());
      try {
        final response = await ApiDatasets.getDatasets();
        emit(DatasetSuccess(listDataset: response));
      } catch (e) {
        print(e);
        emit(DatasetFail(errorMessage: 'Failed to fetch datasets : $e'));
      }
    });
    on<FetchDatasetsWithToken>((event, emit) async {
      emit(DatasetLoading());
      try {
        final response = await ApiDatasets.getDatasetsWithToken();
        emit(DatasetSuccess(listDataset: response));
      } catch (e) {
        print(e);
        emit(DatasetFail(errorMessage: 'Failed to fetch datasets : $e'));
      }
    });
    on<CreateDataset>((event, emit) async {
      emit(DatasetLoading());
      try {
        final response = await ApiDatasets.createDataset(event.createDataset);
        emit(DatasetSuccess(createDataset: response));
      } catch (e) {
        print(e);
        emit(DatasetFail(errorMessage: 'Failed to create dataset $e'));
      }
    });
    on<EditDataset>((event, emit) async {
      emit(DatasetLoading());
      try {
        final response = await ApiDatasets.editDataset(event.editDataset);
        emit(DatasetSuccess(createDataset: response));
      } catch (e) {
        print(e);
        emit(DatasetFail(errorMessage: 'Failed to create dataset $e'));
      }
    });
  }
}
