import 'dart:convert';

import 'package:hive/hive.dart';

class IssuesModel {
  final String title;
  final String body;
  final String commentsUrl;
  final String url;
  final String creador;
  final String creadorUrl;
  final String creadorAvatarUrl;
  final String state;
  final int comments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<LabesIssuesModel?> labels;

  IssuesModel({
    required this.title,
    required this.body,
    required this.commentsUrl,
    required this.url,
    required this.creador,
    required this.creadorUrl,
    required this.creadorAvatarUrl,
    required this.state,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.labels,
  });

  IssuesModel copyWith({
    String? title,
    String? body,
    String? commentsUrl,
    String? url,
    String? creador,
    String? creadorUrl,
    String? creadorAvatarUrl,
    String? state,
    int? comments,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<LabesIssuesModel?>? labels,
  }) {
    return IssuesModel(
      title: title ?? this.title,
      body: body ?? this.body,
      commentsUrl: commentsUrl ?? this.commentsUrl,
      url: url ?? this.url,
      creador: creador ?? this.creador,
      creadorUrl: creadorUrl ?? this.creadorUrl,
      creadorAvatarUrl: creadorAvatarUrl ?? this.creadorAvatarUrl,
      state: state ?? this.state,
      comments: comments ?? this.comments,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      labels: labels ?? this.labels,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'commentsUrl': commentsUrl,
      'creador': creador,
      'creadorUrl': creadorUrl,
      'creadorAvatarUrl': creadorAvatarUrl,
      'state': state,
      'comments': comments,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
      'labels': labels.map((x) => x?.toMap()).toList(),
    };
  }

  factory IssuesModel.fromMap(Map<String, dynamic> map) {
    return IssuesModel(
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      commentsUrl: map['comments_url'] ?? '',
      url: map['html_url'] ?? '',
      creador: map['user']['login'] ?? '',
      creadorUrl: map['user']['html_url'] ?? '',
      creadorAvatarUrl: map['user']['avatar_url'] ?? '',
      state: map['state'] ?? '',
      comments: map['comments']?.toInt() ?? 0,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      labels: List<LabesIssuesModel?>.from(
          map['labels']?.map((x) => LabesIssuesModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory IssuesModel.fromJson(String source) =>
      IssuesModel.fromMap(json.decode(source));
}

class LabesIssuesModel {
  final String url;
  final String name;
  final String color;
  final String description;
  LabesIssuesModel({
    required this.url,
    required this.name,
    required this.color,
    required this.description,
  });

  LabesIssuesModel copyWith({
    String? url,
    String? name,
    String? color,
    String? description,
  }) {
    return LabesIssuesModel(
      url: url ?? this.url,
      name: name ?? this.name,
      color: color ?? this.color,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'name': name,
      'color': color,
      'description': description,
    };
  }

  factory LabesIssuesModel.fromMap(Map<String, dynamic> map) {
    return LabesIssuesModel(
      url: map['url'] ?? '',
      name: map['name'] ?? '',
      color: map['color'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LabesIssuesModel.fromJson(String source) =>
      LabesIssuesModel.fromMap(json.decode(source));
}
