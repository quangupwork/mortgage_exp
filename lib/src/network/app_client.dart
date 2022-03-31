import 'package:graphql/client.dart';
import 'package:mortgage_exp/injector.dart';
import 'package:mortgage_exp/src/bloc/base.dart';
import 'package:mortgage_exp/src/config/app_config.dart';
import 'package:mortgage_exp/src/preferences/app_preference.dart';
import 'package:mortgage_exp/src/utilities/logger.dart';
import 'package:mortgage_exp/static_variable.dart';

class AppClient {
  // Config client (endpoint and token)
  GraphQLClient getClient({String? token}) {
    final defaultHeaders = <String, String>{};
    if (token != null) {
      defaultHeaders['x-token'] = token;
    }
    final Link _link = HttpLink(
      AppConfig.instance.apiEndpoint,
      defaultHeaders: defaultHeaders,
    );

    return GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );
  }

  Future<DataResult<dynamic>> query({
    required String doc,
    Map<String, dynamic> vars = const {},
    String? subKey,
    bool withToken = false,
  }) async {
    try {
      String? token;
      if (withToken) {
        final AppPreference appPreference =
            AppDependencies.injector.get<AppPreference>();
        // token = await appPreference.token ?? StaticVariable.token;
        LoggerUtils.d('TOKEN:\n$token');
      }

      final _client = getClient(token: token);

      LoggerUtils.d(
          '-----------------QUERY GRAPHQL API REQUEST------------------');
      LoggerUtils.d('DOCUMENTS:\n$doc');
      LoggerUtils.d('VARIABLES:\n$vars');

      final options = QueryOptions(
        document: gql(doc),
        variables: vars,
        fetchPolicy: FetchPolicy.networkOnly,
        cacheRereadPolicy: CacheRereadPolicy.ignoreAll,
      );
      final result = await _client.query(options);

      if (result.hasException || result.exception != null) {
        return DataResult.failure(APIFailure(result.exception!.toString()));
      }

      // ignore: prefer_typing_uninitialized_variables
      var data;

      if (subKey != null && result.data != null) {
        LoggerUtils.d(result.data![subKey]);
        data = result.data![subKey];
      } else {
        data = result.data ?? {};
      }

      LoggerUtils.d(
          '-----------------QUERY GRAPHQL API RESPONSE------------------');
      LoggerUtils.d('DATA:\n${result.data}');

      return DataResult.success(data);
    } catch (e) {
      return DataResult.failure(APIFailure(e.toString()));
    }
  }

  Future<DataResult<dynamic>> mutate({
    required String doc,
    Map<String, dynamic> vars = const {},
    String? subKey,
    bool withToken = false,
  }) async {
    try {
      String? token;
      if (withToken) {
        final AppPreference appPreference =
            AppDependencies.injector.get<AppPreference>();
        //    token = await appPreference.token;
      }

      final _client = getClient(token: token);

      LoggerUtils.d(
          '-----------------MUTATION GRAPHQL API REQUEST------------------');
      LoggerUtils.d('DOCUMENTS:\n$doc');
      LoggerUtils.d('TOKEN:\n$token');
      LoggerUtils.d('VARIABLES:\n$vars');

      final options = MutationOptions(
        document: gql(doc),
        variables: vars,
        fetchPolicy: FetchPolicy.networkOnly,
        cacheRereadPolicy: CacheRereadPolicy.ignoreAll,
      );
      final result = await _client.mutate(options);

      if (result.hasException || result.exception != null) {
        return DataResult.failure(
            APIFailure(result.exception!.graphqlErrors[0].message.toString()));
      }

      // ignore: prefer_typing_uninitialized_variables
      var data;

      if (subKey != null && result.data != null) {
        LoggerUtils.d(result.data![subKey]);
        data = result.data![subKey];
      } else {
        data = result.data ?? {};
      }

      LoggerUtils.d(
          '-----------------MUTATION GRAPHQL API RESPONSE------------------');
      LoggerUtils.d('DATA:\n${result.data}');

      return DataResult.success(data);
    } catch (e) {
      return DataResult.failure(APIFailure(e.toString()));
    }
  }
}
