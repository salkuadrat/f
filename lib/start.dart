import 'dart:async';
import 'dart:io';

FutureOr start(String exec, List<String> args) async {
  Process.start(
    exec,
    args,
    runInShell: true,
    mode: ProcessStartMode.inheritStdio,
  );
}
