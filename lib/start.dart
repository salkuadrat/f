import 'dart:async';
import 'dart:io';

/// starting a process to run command
Future<void> start(String exec, List<String> args) async {
  Process process = await Process.start(
    exec,
    args,
    runInShell: true,
    mode: ProcessStartMode.inheritStdio,
  );

  ProcessSignal.sigint.watch().listen((event) {
    process.exitCode.then((_) => exit(0));
    process.kill();
  });

  process.exitCode.then((_) {
    exit(0);
  });
}
