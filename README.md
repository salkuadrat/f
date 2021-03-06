# F

A simple shortcut, command line interface (CLI) for Flutter to increase productivity and happiness.

## Installation 

To activate f CLI from your terminal.

```bash 
pub global activate f
```

### Windows Problem 

For those of you who use Windows, you might experience a "double run" problem, where some f commands will be called twice. 

It's a [known problem](https://github.com/dart-lang/pub/issues/2934) that comes with pub (and affected every CLI package in pub.dev).

The solution for this problem, for now, is to activate f locally, by first cloning the repository to your local drive.

```bash
git clone https://github.com/salkuadrat/f
```

Then activate it with this command.

```bash
pub global activate --source path <f-location>
```

As example, if you run `git clone` on the root of drive D, then the activate command will be...

```bash
pub global activate --source path "D:\f"
```

This kind of local activation will nicely handle the "double run" problem on Windows.

## Create Project 

Use this command to create a Flutter project:

```bash 
f c myapp
```

It's the same as `flutter create myapp`.

To create Flutter project with some predefined dependencies, you can list them after the project name.

```bash
f c myapp path intl http provider
```

The command above will generate `myapp` project in `myapp` directory, and automatically install all the required dependencies (for this example: path, intl, http & provider).

You can also pass other arguments, like project name, organization name, or specify the programming language used for the native platform.

```bash 
f c -p myapp -o dev.flutter -a kotlin -i swift myapp path intl http provider
```

## Starter Project

Starter project is a Flutter template that you can use for your new project.

To create a starter project:

```bash
f s myapp
```

By default `f s` command will generate a starter project with Provider.

If you want starter project with other state management (BLoC, Cubit, GetX, or Riverpod), you can specify it in the `f s` command.

```bash
f s --bloc myapp

f s --cubit myapp

f s --getx myapp

f s --riverpod myapp
```

You can also pass additional arguments.

```bash
f s -p myapp -o dev.flutter -a kotlin -i swift myapp
```

To see the structure of starter project generated by `f s` command, you can explore the examples below.

[starter_bloc](starter_bloc)\
[starter_cubit](starter_cubit)\
[starter_getx](starter_getx)\
[starter_riverpod](starter_riverpod)\
[starter_provider](starter_provider)

After creating a starter project with `f s`, you can use `f m` command to generate a new module inside the project, like:

```bash
f m posts
```

It will auto-detect the state management in your project, and generate all the module files accordingly.

## Run Project 

Run your Flutter project with this command.

```bash 
f r
```

It's the same as `flutter run`.

To run project as `flutter run --profile`:

```bash 
f rp
```

To run project as `flutter run --release`:

```bash 
f rr
```

You can add `-v` to the end of f command to display the complete diagnostic informations.

```bash
f r -v
```

## Build Project 

To build executable for a Flutter project, use:

```bash
f b apk

f b arr

f b appbundle

f b bundle 

f b web
```

To build apk with split per abi:

```bash
f bs apk
```

## Other Commands 

The complete list of f commands that you can use for Flutter.

<table>
  <tr>
    <th>Command</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>f a -d DEVICE_ID</code></td>
    <td>Analyzes the project???s Dart source code.<br>Alias of <code>flutter analyze</code></td>
  </tr>
  <tr>
    <td><code>f as -o DIRECTORY</code></td>
    <td>Assemble and build flutter resources.<br>Alias of <code>flutter assemble</code></td>
  </tr>
  <tr>
    <td><code>f at -d DEVICE_ID</code></td>
    <td>Attach to a running application.<br>Alias of <code>flutter attach</code></td>
  </tr>
  <tr>
    <td><code>f b DIRECTORY</code></td>
    <td>Flutter build commands.<br>Alias of <code>flutter build</code></td>
  </tr>
  <tr>
    <td><code>f bs DIRECTORY</code></td>
    <td>Flutter build commands with split per abi.<br>Alias of <code>flutter build --split-per-abi</code></td>
  </tr>
  <tr>
    <td><code>f ch CHANNEL_NAME</code></td>
    <td>List or switch flutter channels.<br>Alias of <code>flutter channel</code></td>
  </tr>
  <tr>
    <td><code>f cl</code></td>
    <td>Clean a flutter project.<br>Alias of <code>flutter clean</code></td>
  </tr>
  <tr>
    <td><code>f dev -d DEVICE_ID</code></td>
    <td>List all connected devices.<br>Alias of <code>flutter devices</code></td>
  </tr>
  <tr>
    <td><code>f doc</code></td>
    <td>Show information about the installed tooling.<br>Alias of <code>flutter doctor</code></td>
  </tr>
  <tr>
    <td><code>f drv</code></td>
    <td>Runs Flutter Driver tests for the current project.<br>Alias of <code>flutter drive</code></td>
  </tr>
  <tr>
    <td><code>f e</code></td>
    <td>List, launch and create emulators.<br>Alias of <code>flutter emulators</code></td>
  </tr>
  <tr>
    <td><code>f f DIRECTORY|DART_FILE</code></td>
    <td>Formats Flutter source code.<br>Alias of <code>flutter format</code></td>
  </tr>
  <tr>
    <td><code>f i -d DEVICE_ID</code></td>
    <td>Install a Flutter app on an attached device.<br>Alias of <code>flutter install</code></td>
  </tr>
  <tr>
    <td><code>f l</code></td>
    <td>Show log output for running Flutter apps.<br>Alias of <code>flutter logs</code></td>
  </tr>
  <tr>
    <td><code>f t [DIRECTORY|DART_FILE]</code></td>
    <td>Runs tests in this package.<br>Alias of <code>flutter test</code></td>
  </tr>
  <tr>
    <td><code>f up</code></td>
    <td>Upgrade your copy of Flutter.<br>Alias of <code>flutter upgrade</code></td>
  </tr>
  <tr>
    <td><code>f down</code></td>
    <td>Downgrade Flutter to the last active version for the current channel. Alias of <code>flutter downgrade</code></td>
  </tr>
</table>