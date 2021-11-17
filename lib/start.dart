import 'dart:async';
import 'dart:io';

FutureOr start(String exec, List<String> args) async {
  final p = await Process.start(exec, args, runInShell: true);
  stdout.addStream(p.stdout);
}