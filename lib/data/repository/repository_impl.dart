import 'package:flutter/cupertino.dart';
import 'package:vitec_travels/data/repository/repository.dart';
import '../../domain/model/travel_response.dart';
import '../services/remote/remote.dart';

class RepositoryImpl extends Repository {
  final Remote remote;

  RepositoryImpl(this.remote);

  @override
  Future<String?> getTravelData() async {
    return await remote.getTravelData();
  }


}