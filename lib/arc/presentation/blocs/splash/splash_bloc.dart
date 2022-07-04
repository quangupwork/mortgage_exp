import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mortgage_exp/static_variable.dart';
import 'package:xml/xml.dart';
import '../../../../injector.dart';
import '../../../../src/bloc/base.dart';
import '../../../../src/constants.dart';
import '../../../../src/helper/html_helper.dart';
import '../../../../src/preferences/app_preference.dart';
import '../../../../src/utilities/logger.dart';
import '../../../data/models/models.dart';
import '../../../data/services/post_service.dart';
import '../blocs.dart';

class SplashBloc extends IBaseBloc {
  final PostService postService;
  SplashBloc(this.postService);
  final AppPreference appPreference =
      AppDependencies.injector.get<AppPreference>();
  List<String> result = [];
  @override
  void registerEvents() {
    registerEvent<SplashLoadEvent>(
        (event) => _loadData(event as SplashLoadEvent));
  }

  Stream<IBaseState> _loadData(SplashLoadEvent event) async* {
    yield SplashLoadingState();

    List<DocumentModel> listDocument = [];
    //Load document
    final res = await Dio()
        .request('https://www.mortgage-express.co.nz/find-adviser/rss.xml');
    final document = XmlDocument.parse(res.data);
    final items = document.findAllElements('item');
    for (var element in items) {
      final description = element.findAllElements('description').toString();
      final link = description
              .split('href=')
              .toList()
              .last
              .split('.pdf')
              .toList()[0]
              .replaceAll("\"", '') +
          '.pdf';
      final title = element.findAllElements('title').toString();
      final document = DocumentModel(
        link: link,
        title: HTMLHelper.parseHtmlString(title),
      );
      listDocument.add(document);
    }
    LoggerUtils.d("Fetch new data");
    StaticVariable.listDocument = listDocument;
    final convertList = listDocument.map((e) => jsonEncode(e)).toList();
    await appPreference.setSaveDocument(convertList);

    // Get API POST
    final resPost = await postService.getPost();
    if (resPost.isFailure) {
      yield ErrorPoststate();
      return;
    }
    final response = PostResponse.fromJson(resPost.data);
    response.postModel?.sort((a, b) => a.name!.compareTo(b.name!));

    final convertListPost =
        response.postModel?.map((e) => jsonEncode(e)).toList();
    await appPreference.setSavePost(convertListPost);
    LoggerUtils.d("Reload post success");

    // Get List FILTER
    final getFilter = await appPreference.saveFilter ?? [];
    if (getFilter.isEmpty) {
      // Get API TOPIC
      final resTopic = await postService.getTopic();
      if (resTopic.isFailure) {
        yield ErrorPoststate();
        return;
      }
      final responseTopic = TopicResponse.fromJson(resTopic.data);

      for (var categoryID in Constants.categoryIDS) {
        int index = -1;
        index =
            responseTopic.topicModel?.indexWhere((id) => id.id == categoryID) ??
                -1;
        if (index != -1) {
          result.add(responseTopic.topicModel?[index].name ?? '');
        }
      }
      result[0] = 'All regions';
      StaticVariable.listTopic = result;
      await appPreference.setSaveFilter(result);
      LoggerUtils.d("Save topic success");
    } else {
      final listTopic = await appPreference.saveFilter ?? [];
      int index = listTopic.indexOf('All region');
      if (index != -1) {
        listTopic[index] = 'All regions';
      }
      StaticVariable.listTopic = listTopic;
    }
    yield SplashLoadedState();
  }
}
