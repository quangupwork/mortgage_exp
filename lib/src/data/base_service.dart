import 'package:mortgage_exp/injector.dart';
import 'package:mortgage_exp/src/network/app_client.dart';

abstract class BaseService {
  final client = AppDependencies.injector.get<AppClient>();
}
