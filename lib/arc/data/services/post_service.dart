import 'package:mortgage_exp/src/bloc/base.dart';
import 'package:mortgage_exp/src/data/data.dart';

class PostService extends BaseService {
  Future<DataResult> getPost() async {
    Map<String, dynamic>? queryParameters = {
      "hapikey": "60c5f728-e24d-4ce2-95c3-81f9288aa9d9",
      "content_group_id": 3883359436,
      "limit": 1000,
      "state": 'PUBLISHED'
    };
    return await client.getAPI('content/api/v2/blog-posts', queryParameters);
  }

  Future<DataResult> getTopic() async {
    Map<String, dynamic>? queryParameters = {
      "hapikey": "60c5f728-e24d-4ce2-95c3-81f9288aa9d9",
      "limit": 1000,
    };
    return await client.getAPI('blogs/v3/topics', queryParameters);
  }
}
