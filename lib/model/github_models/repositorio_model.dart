import 'dart:convert';

import 'package:hive/hive.dart';

part 'repositorio_model.g.dart';

@HiveType(typeId: 1)
class RepositorioModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String nodeId;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String fullName;
  @HiveField(4)
  final bool private;
  @HiveField(5)
  final String htmlUrl;
  @HiveField(6)
  final String? description;
  @HiveField(7)
  final String url;
  @HiveField(8)
  final String branchesUrl;
  @HiveField(9)
  final String tagsUrl;
  @HiveField(10)
  final String languagesUrl;
  @HiveField(11)
  final String commitsUrl;
  @HiveField(12)
  final String archiveUrl;
  @HiveField(13)
  final DateTime createdAt;
  @HiveField(14)
  final DateTime updatedAt;
  @HiveField(15)
  final DateTime pushedAt;
  @HiveField(16)
  final String gitUrl;
  @HiveField(17)
  final String sshUrl;
  @HiveField(18)
  final String cloneUrl;
  @HiveField(19)
  final String svnUrl;
  @HiveField(20)
  final String? homepage;
  @HiveField(21)
  final String language;
  @HiveField(22)
  final String visibility;
  @HiveField(23)
  final String creador;
  @HiveField(25)
  final String creadorUrl;

  RepositorioModel({
    required this.id,
    required this.nodeId,
    required this.name,
    required this.fullName,
    required this.private,
    required this.htmlUrl,
    this.description,
    required this.url,
    required this.branchesUrl,
    required this.tagsUrl,
    required this.languagesUrl,
    required this.commitsUrl,
    required this.archiveUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.pushedAt,
    required this.gitUrl,
    required this.sshUrl,
    required this.cloneUrl,
    required this.svnUrl,
    this.homepage,
    required this.language,
    required this.visibility,
    required this.creador,
    required this.creadorUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'node_id': nodeId,
      'name': name,
      'full_name': fullName,
      'private': private,
      'html_url': htmlUrl,
      'description': description,
      'url': url,
      'branches_url': branchesUrl,
      'tags_url': tagsUrl,
      'languages_url': languagesUrl,
      'commits_url': commitsUrl,
      'archive_url': archiveUrl,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
      'pushed_at': pushedAt.toString(),
      'git_url': gitUrl,
      'ssh_url': sshUrl,
      'clone_url': cloneUrl,
      'svn_url': svnUrl,
      'homepage': homepage,
      'language': language,
      'visibility': visibility,
      'creador': creador,
      'creador_url': creadorUrl,
    };
  }

  factory RepositorioModel.fromMap(Map<String, dynamic> map) {
    return RepositorioModel(
      id: map['id']?.toInt() ?? 0,
      nodeId: map['node_id'] ?? '',
      name: map['name'] ?? '',
      fullName: map['full_name'] ?? '',
      private: map['private'] ?? false,
      htmlUrl: map['html_url'] ?? '',
      description: map['description'],
      url: map['url'] ?? '',
      branchesUrl: map['branches_url'] ?? '',
      tagsUrl: map['tags_url'] ?? '',
      languagesUrl: map['languages_url'] ?? '',
      commitsUrl: map['commits_url'] ?? '',
      archiveUrl: map['archive_url'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      pushedAt: DateTime.parse(map['pushed_at']),
      gitUrl: map['git_url'] ?? '',
      sshUrl: map['ssh_url'] ?? '',
      cloneUrl: map['clone_url'] ?? '',
      svnUrl: map['svn_url'] ?? '',
      homepage: map['homepage'],
      language: map['language'] ?? '',
      visibility: map['visibility'] ?? '',
      creador: map['owner']['login'] ?? '',
      creadorUrl: map['owner']['html_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RepositorioModel.fromJson(String source) =>
      RepositorioModel.fromMap(json.decode(source));

  RepositorioModel copyWith({
    int? id,
    String? nodeId,
    String? name,
    String? fullName,
    bool? private,
    String? htmlUrl,
    String? description,
    String? url,
    String? branchesUrl,
    String? tagsUrl,
    String? languagesUrl,
    String? commitsUrl,
    String? archiveUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? pushedAt,
    String? gitUrl,
    String? sshUrl,
    String? cloneUrl,
    String? svnUrl,
    String? homepage,
    String? language,
    String? visibility,
    String? creador,
    String? creadorUrl,
  }) {
    return RepositorioModel(
      id: id ?? this.id,
      nodeId: nodeId ?? this.nodeId,
      name: name ?? this.name,
      fullName: fullName ?? this.fullName,
      private: private ?? this.private,
      htmlUrl: htmlUrl ?? this.htmlUrl,
      description: description ?? this.description,
      url: url ?? this.url,
      branchesUrl: branchesUrl ?? this.branchesUrl,
      tagsUrl: tagsUrl ?? this.tagsUrl,
      languagesUrl: languagesUrl ?? this.languagesUrl,
      commitsUrl: commitsUrl ?? this.commitsUrl,
      archiveUrl: archiveUrl ?? this.archiveUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pushedAt: pushedAt ?? this.pushedAt,
      gitUrl: gitUrl ?? this.gitUrl,
      sshUrl: sshUrl ?? this.sshUrl,
      cloneUrl: cloneUrl ?? this.cloneUrl,
      svnUrl: svnUrl ?? this.svnUrl,
      homepage: homepage ?? this.homepage,
      language: language ?? this.language,
      visibility: visibility ?? this.visibility,
      creador: creador ?? this.creador,
      creadorUrl: creadorUrl ?? this.creadorUrl,
    );
  }
}
