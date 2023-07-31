part of 'organisasi_bloc.dart';

abstract class OrganisasiEvent extends Equatable {
  const OrganisasiEvent();

  @override
  List<Object?> get props => [];
}

class FetchOrganisasi extends OrganisasiEvent {}

class FetchOrganisasiWithToken extends OrganisasiEvent {}

class CreateOrganisasi extends OrganisasiEvent {
  final ResponseOrganization organization;

  const CreateOrganisasi({required this.organization});

  @override
  List<Object> get props => [organization];
}

class EditOrganisasi extends OrganisasiEvent {
  final ResponseOrganization organization;

  const EditOrganisasi({required this.organization});

  @override
  List<Object> get props => [organization];
}

class DeleteOrganisasi extends OrganisasiEvent {
  final int id;

  const DeleteOrganisasi({required this.id});

  @override
  List<Object> get props => [id];
}
