import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vitec_travels/data/core/table_constant.dart';
import 'package:vitec_travels/ui/base/base.vm.dart';
import '../../domain/model/travel_response.dart';

class HomeViewModel extends BaseViewModel{

  final TextEditingController searchController = TextEditingController();
  Map<String, dynamic>? data;
  List<Nearby>? nearby;
  List<Popular>? popular;
  List<Map<String, dynamic>>? populars;
  bool viewMore = false;
  bool popViewMore = false;

  updatePageIndex() {
    viewMore=!viewMore;
    notifyListeners();
  }

  updatePopPageIndex() {
    popViewMore=!popViewMore;
    notifyListeners();
  }

  getFromStore() async {
    startLoader();
    var use = await storageService.readItem(key: DbTable.TRAVELS);
    use==null? getTravelData():data = json.decode(use);
    nearby = getNearbyListFromJson(jsonEncode(data?["data"]["nearby"]));
    populars =jsonDecode(jsonEncode(data?["data"]["popular"])).cast<Map<String,dynamic>>();
    stopLoader();
  }

  Future<String?> getTravelData() async{
    startLoader();
    try{
      final response = await repository.getTravelData();
      response!=null || response!="null"? storageService.storeItem(key: DbTable.TRAVELS, value: response):(){};
      var results = await storageService.readItem(key: DbTable.TRAVELS);
      results==null?(){}:getFromStore();
      stopLoader();
      return response;
    }catch(error){
      stopLoader();
    }
  }
}