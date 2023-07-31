// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:satudata_mobile/data/request/api_organization.dart';

import '../../../../../data/models/organization/response_organization.dart';

part 'organisasi_event.dart';
part 'organisasi_state.dart';

class OrganisasiBloc extends Bloc<OrganisasiEvent, OrganisasiState> {
  OrganisasiBloc() : super(OrganisasiInitial()) {
    on<FetchOrganisasi>(
      (event, emit) async {
        emit(OrganisasiLoading());
        try {
          final response = await ApiOrganization.getOrganization();
          emit(OrganisasiSuccess(organisasi: response));
        } catch (e) {
          emit(
            const OrganisasiError(
              errorMessage: 'Failed to fetch organizations',
            ),
          );
        }
      },
    );
    on<FetchOrganisasiWithToken>(
      (event, emit) async {
        emit(OrganisasiLoading());
        try {
          final response = await ApiOrganization.getOrganizationWithToken();
          emit(OrganisasiSuccess(organisasi: response));
        } catch (e) {
          emit(
            const OrganisasiError(
              errorMessage: 'Failed to fetch organizations',
            ),
          );
        }
      },
    );
    on<CreateOrganisasi>(
      (event, emit) async {
        emit(OrganisasiLoading());
        try {
          final response =
              await ApiOrganization.createOrganization(event.organization);
          emit(OrganisasiSuccess(editOrganisasi: response));
        } catch (e) {
          print(e);
          emit(
            const OrganisasiError(
              errorMessage: 'Failed to edit organizations',
            ),
          );
        }
      },
    );
    on<EditOrganisasi>(
      (event, emit) async {
        emit(OrganisasiLoading());
        try {
          final response =
              await ApiOrganization.editOrganizations(event.organization);
          emit(OrganisasiSuccess(editOrganisasi: response));
        } catch (e) {
          print(e);
          emit(
            const OrganisasiError(
              errorMessage: 'Failed to edit organizations',
            ),
          );
        }
      },
    );
    on<DeleteOrganisasi>((event, emit) async {
      emit(OrganisasiLoading());
      try {
        final response = await ApiOrganization.deleteOrganization(event.id);
        emit(OrganisasiSuccess(deleteOrganisasi: response));
      } catch (e) {
        print(e);
        emit(
          const OrganisasiError(
            errorMessage: 'Failed to delete organizations',
          ),
        );
      }
    });
  }
}
