import 'package:get/get.dart';
import 'package:yolanda/models/habit_model.dart';
import 'package:yolanda/repositories/Habit_Http_Repository.dart';

class Habit_Controller extends GetxController {
  final Habit_Http_Repository habit_http_repository;
  Habit_Controller(this.habit_http_repository);

  Future<List<String>> getFrequenciesController() async {

    try {
      return habit_http_repository.frequencies;
    } catch (e) {
      return [];
    }
  }

  Future<List<HabitModel>> getHabitsController({
    required Function(bool) loading,
  }) async {
    loading(true);
    try {
      return habit_http_repository.habits;
    } catch (e) {
      return [];
    }finally{
      loading(false);
    }
  }

  Future<bool> createHabitsController({
    required HabitModel habitModel,
    required Function(bool) loading,
  }) async {
    loading(true);
    try {
      bool response = habit_http_repository.createHabit(habitModel);
      return response;
    } catch (e) {
      return false;
    }finally{
      loading(false);
    }
  }


}
