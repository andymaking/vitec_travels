import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vitec_travels/data/services/remote/remote.dart';
import 'package:vitec_travels/util/snack_message.dart';

import '../../../domain/model/travel_response.dart';
import '../../core/network_config.dart';

class RemoteImpl extends Remote {
  final Dio dio;

  RemoteImpl(this.dio);

  @override
  Future<String?> getTravelData() async {

    try{
      var response = await dio.get("${NetworkConfig.BASE_URL}getRoutes.php",
          options: Options(followRedirects: false, headers: {
            "Accept": "application/json",
            'Authorization': "Basic ${NetworkConfig.Auth}"
          })
      );
      if(response.statusCode==200){
      return response.data.toString();
      }else{

        print(response.statusCode);
      }
    }  catch(error){
      handleError(error );
    }

  }



}