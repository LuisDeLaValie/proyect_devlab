import 'dart:io';

class GitServices {
  /// funcion que verifica si una ruta es un repositorio git
  Future<bool> isRepo(String directory) async {
    try {
      var res = await Process.run('ls', ['-lax', directory], runInShell: true);
      if (res.exitCode != 0) throw res.stderr;

      var archAux = (res.stdout as String).replaceAll(RegExp("\t"), "\n");
      var arch = archAux.split("\n");

      return arch.contains(".git");
    } catch (e) {
      rethrow;
    }
  }





  /// funcion que obtiene las ramas del repositorio
  Future<List<String>?> getBranch(String directory) async {
    try {
      await Process.start("cd", [directory], runInShell: true);
      // git branch -a | grep -v ‘remotes’
      var res = await Process.run('git', ['branch'], runInShell: true);
      if (res.exitCode != 0) throw res.stderr;
      var branch = (res.stdout as String).split("\n");
      print(res.stdout);
      branch.removeWhere((element) => element.isEmpty);
      
      return branch;
    } catch (e) {
      rethrow;
    }
  }

  /// funcion que obtiene el commit actual del repositorio
  Future<String?> getCommit(String directory) async {
    try {
      await Process.start("cd", [directory], runInShell: true);
      var res = await Process.run('git', ['rev-parse', '--short', 'HEAD'],
          runInShell: true);
      if (res.exitCode != 0) throw res.stderr;
      var commit = ((res.stdout ?? "") as String).replaceAll("\n", "");
      return commit;
    } catch (e) {
      rethrow;
    }
  }

  /// funcion que obtiene los commits del repositorio
  Future<List<String>?> getCommits(String directory) async {
    try {
      await Process.start("cd", [directory], runInShell: true);
      var res = await Process.run(
          'git', ['log', '--pretty=format:"%h <> %H <> %an <> %ar <> %s"'],
          runInShell: true);
      if (res.exitCode != 0) throw res.stderr;
      var commits = (res.stdout as String).replaceAll("\"", "").split("\n");
      commits.removeWhere((element) => element.isEmpty);
      return commits;
    } catch (e) {
      rethrow;
    }
  }
}
