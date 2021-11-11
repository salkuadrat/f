String arguments(List<String> args) {
  if (args.length > 1) {
    args[0] = '';
    return args.join(' ').trim();
  }
  return '';
}
