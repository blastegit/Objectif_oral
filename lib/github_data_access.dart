import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:github/github.dart';

class GitHubDownloader extends StatefulWidget {
  const GitHubDownloader({Key? key}) : super(key: key);

  @override
  _GitHubDownloaderState createState() => _GitHubDownloaderState();
}

class _GitHubDownloaderState extends State<GitHubDownloader> {
  final owner = 'owner';
  final repositoryName = 'repository-name';
  final branch = 'master';

  List<String> fileNames = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Downloader'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Download'),
          onPressed: () async {
            final github = GitHub();
            final repository = await github.repositories.getRepository(RepositorySlug(owner, repositoryName));
            final contents = await repository.getContents(branch: branch);
            final files = contents.where((content) => content.type == 'file').toList();
            setState(() {
              fileNames = files.map((file) => file.name!).toList();
            });
            for (var file in files) {
              final content = await repository.getContents(file.path!, branch: branch);
              final bytes = base64.decode(content.content!);
              final directory = await getApplicationDocumentsDirectory();
              final path = '${directory.path}/${file.name}';
              final file = File(path);
              await file.writeAsBytes(bytes);
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Files: ${fileNames.join(", ")}',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
