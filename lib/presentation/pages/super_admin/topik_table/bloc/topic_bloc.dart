import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satudata_mobile/data/request/api_topic.dart';

import '../../../../../data/models/topic/response_topic.dart';

part 'topic_event.dart';
part 'topic_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  TopicBloc() : super(TopicInitial()) {
    on<FetchTopics>(
      (event, emit) async {
        emit(TopicLoading());
        try {
          final response = await ApiTopic.getTopics();
          emit(TopicSuccess(topic: response));
        } catch (e) {
          print(e);
          emit(const TopicFail(errorMessage: 'Failed to fetch topics'));
        }
      },
    );
    on<FetchTopicsWithToken>(
      (event, emit) async {
        emit(TopicLoading());
        try {
          final response = await ApiTopic.getTopicsWithToken();
          emit(TopicSuccess(topic: response));
        } catch (e) {
          print(e);
          emit(const TopicFail(errorMessage: 'Failed to fetch topics'));
        }
      },
    );
    on<CreateTopic>(
      (event, emit) async {
        emit(TopicLoading());
        try {
          final responseCreate =
              await ApiTopic.createOrganization(event.createTopic);
          emit(TopicSuccess(createTopic: responseCreate));
        } catch (e) {
          print(e);
        }
      },
    );
    on<EditTopic>(
      (event, emit) async {
        emit(TopicLoading());
        try {
          final response = await ApiTopic.editTopic(event.topic);
          emit(TopicSuccess(editTopic: response));
        } catch (e) {
          print(e);
        }
      },
    );
    on<DeleteTopic>(
      (event, emit) async {
        emit(TopicLoading());
        try {
          final response = await ApiTopic.deleteTopic(event.id);
          emit(TopicSuccess(deleteTopic: response));
        } catch (e) {
          print(e);
        }
      },
    );
  }
}
