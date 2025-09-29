import 'package:yolanda/models/habit_model.dart';
import 'package:yolanda/network/api_manager.dart';
import 'package:yolanda/network/app_network_url.dart';
import 'package:yolanda/utils/app_helpers.dart';

class Habit_Http_Repository extends ApiManager {
  Habit_Http_Repository() :super(baseUrl: AppNetworkUrl.baseStUrl);

  final _excecptionCode =AppHelpers.exceptionCode;
  final _errorCode =AppHelpers.exceptionCode;
  final _parsingError =AppHelpers.parsingError;

  List<String> frequencies = ["Daily", "Weekly", "Monthly"];

  static List<HabitModel> habitsTest = [
    HabitModel.fromJson({
      "name": "Cooking",
      "frequency": "Weekly",
      "status": "Completed",
      "dateCreated": "2023-11-21",
      "dateUpdated": "2023-11-21",
    }),
  ];

  List<HabitModel> habits = [
    HabitModel.fromJson({
      "name": "Cooking",
      "frequency": "Weekly",
      "status": "Completed",
      "dateCreated": "2023-11-21",
      "dateUpdated": "2023-11-21",
    }),
  ];

  createHabit(HabitModel habitModel){

    try{
      habits.add(habitModel);
      return true;
    }catch(e){
      return false;
    }

  }

}