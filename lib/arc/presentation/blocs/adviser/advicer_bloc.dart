import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mortgage_exp/src/helper/html_helper.dart';
import 'package:mortgage_exp/static_variable.dart';
import 'package:xml/xml.dart' as xml;
import 'package:mortgage_exp/arc/presentation/blocs/blocs.dart';
import 'package:mortgage_exp/src/utilities/utilities.dart';
import 'package:xml/xml.dart';

import '../../../../injector.dart';
import '../../../../src/bloc/base.dart';
import '../../../../src/preferences/app_preference.dart';
import '../../../data/models/models.dart';
import '../../../data/services/post_service.dart';

class PostBloc extends IBaseBloc {
  final PostService postService;
  PostBloc(this.postService);
  final appPreference = AppDependencies.injector.get<AppPreference>();

  @override
  void registerEvents() {
    registerEvent<LoadPostEvent>((event) => _getData(event as LoadPostEvent));
    registerEvent<ChangeFilterEvent>(
        (event) => _changeFilter(event as ChangeFilterEvent));
  }

  Stream<IBaseState> _getData(LoadPostEvent event) async* {
    yield LoadingPostState();
    final getDocument = await appPreference.saveDocument ?? [];
    if (getDocument.isEmpty) {
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
      StaticVariable.listDocument = listDocument;
      final convertList = listDocument.map((e) => jsonEncode(e)).toList();
      await appPreference.setSaveDocument(convertList);
    } else {
      // Get LOCAL
      List<DocumentModel>? documentModel = [];
      final document = await appPreference.saveDocument ?? [];
      for (var element in document) {
        final documentMap = jsonDecode(element);
        final document = DocumentModel.fromJson(documentMap);
        documentModel.add(document);
      }
      StaticVariable.listDocument = documentModel;
    }

    // Get List FILTER
    final getPost = await appPreference.savePost ?? [];
    if (getPost.isEmpty) {
      // Get API POST
      final resPost = await postService.getPost();
      if (resPost.isFailure) {
        yield ErrorPoststate();
        return;
      }
      final response = PostResponse.fromJson(resPost.data);
      response.postModel?.sort((a, b) => a.name!.compareTo(b.name!));

      final convertList =
          response.postModel?.map((e) => jsonEncode(e)).toList();
      await appPreference.setSavePost(convertList);
      LoggerUtils.d("Save post success");

      yield LoadedPoststate(postModel: response.postModel);
    } else {
      // Get LOCAL
      List<PostModel>? postModel = [];
      final post = await appPreference.savePost ?? [];
      for (var element in post) {
        final postMap = jsonDecode(element);
        final post = PostModel.fromJson(postMap);
        postModel.add(post);
      }
      yield LoadedPoststate(postModel: postModel);
    }
  }

  Stream<IBaseState> _changeFilter(ChangeFilterEvent event) async* {
    yield ChangeFilterState(filter: event.value);
  }
}
