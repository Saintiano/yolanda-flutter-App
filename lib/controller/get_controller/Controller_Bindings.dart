
import 'package:get/get.dart';

import '../../services/auth_services.dart';
import '../utility_controller.dart';
import '../validator_controller.dart';


class Controler_Binding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AuthServices>(() => AuthServices());
    Get.lazyPut<Utility_Controller>(() => Utility_Controller());
    Get.lazyPut<ValidatorsController>(() => ValidatorsController());
  }

}