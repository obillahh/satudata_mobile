// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'organisasi_bloc.dart';

abstract class OrganisasiState extends Equatable {
  const OrganisasiState();

  @override
  List<Object?> get props => [];
}

class OrganisasiInitial extends OrganisasiState {}

class OrganisasiLoading extends OrganisasiState {}

class OrganisasiSuccess extends OrganisasiState {
  final List<ResponseOrganization>? organisasi;
  final ResponseOrganization? createOrganisasi;
  final ResponseOrganization? editOrganisasi;
  final int? deleteOrganisasi;

  const OrganisasiSuccess({
    this.organisasi,
    this.createOrganisasi,
    this.editOrganisasi,
    this.deleteOrganisasi,
  });

  @override
  List<Object> get props => [
        organisasi!,
        createOrganisasi!,
        editOrganisasi!,
        deleteOrganisasi!,
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrganisasiSuccess &&
          runtimeType == other.runtimeType &&
          listEquals(organisasi, other.organisasi) &&
          createOrganisasi == other.createOrganisasi &&
          editOrganisasi == other.editOrganisasi &&
          deleteOrganisasi == other.deleteOrganisasi);

  @override
  int get hashCode =>
      organisasi.hashCode ^
      createOrganisasi.hashCode ^
      editOrganisasi.hashCode ^
      deleteOrganisasi.hashCode;
}

class OrganisasiError extends OrganisasiState {
  final String errorMessage;

  const OrganisasiError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
