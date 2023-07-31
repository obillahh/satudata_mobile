part of 'topic_bloc.dart';

abstract class TopicEvent extends Equatable {
  const TopicEvent();

  @override
  List<Object?> get props => [];
}

class FetchTopics extends TopicEvent {}

class FetchTopicsWithToken extends TopicEvent {}

class CreateTopic extends TopicEvent {
  final ResponseTopic createTopic;

  const CreateTopic({required this.createTopic});

  @override
  List<Object> get props => [createTopic];
}

class EditTopic extends TopicEvent {
  final ResponseTopic topic;

  const EditTopic({required this.topic});

  @override
  List<Object> get props => [topic];
}

class DeleteTopic extends TopicEvent {
  final int id;

  const DeleteTopic({required this.id});

  @override
  List<Object> get props => [id];
}
