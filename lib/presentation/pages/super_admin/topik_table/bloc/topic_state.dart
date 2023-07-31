part of 'topic_bloc.dart';

abstract class TopicState extends Equatable {
  const TopicState();

  @override
  List<Object> get props => [];
}

class TopicInitial extends TopicState {}

class TopicLoading extends TopicState {}

class TopicSuccess extends TopicState {
  final List<ResponseTopic>? topic;
  final ResponseTopic? createTopic;
  final ResponseTopic? editTopic;
  final int? deleteTopic;

  const TopicSuccess({
    this.topic,
    this.createTopic,
    this.editTopic,
    this.deleteTopic,
  });

  @override
  List<Object> get props => [topic!, createTopic!, editTopic!, deleteTopic!];
}

class TopicFail extends TopicState {
  final String errorMessage;

  const TopicFail({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
