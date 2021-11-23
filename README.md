# f 

A simple shortcut, command line interface (CLI) for Flutter to increase productivity and happiness.

## Installation 

Use this command to activate f CLI from your terminal.

```bash 
pub global activate f
```

## Create new project 

Use this f command to create a Flutter project:

```bash 
f c myapp
```

It's similar to using command `flutter create myapp`.

To create a Flutter project with some predefined dependencies, you can list the dependencies after your project name like this:

```bash
f c myapp path intl http provider 
```

The above command will automatically create `myapp` project in the `myapp` directory, then automatically install all the required dependencies (in this example: path, intl, http, and provider).

Feel free to add as many dependencies as you want.

You can also pass other arguments, such as project name, the organization name, or to specify the programming language used for the native platform:

```bash 
f c --p myapp --org dev.flutter --a kotlin --i swift myapp path intl http provider
```

## Run Project 

To run a Flutter project, you can use this command:

```bash 
f r
```

It's similar to using command `flutter run`. 

To run project as `flutter run --profile`, use:

```bash 
f rp
```

To run project as `flutter run --release`, use:

```bash 
f rr
```

You can combine `-v` at the end of each command to show additional diagnostic informations.

```bash
f r -v
```

## Build Project 

To build executable for a Flutter project, you can use this command:

```bash
f b apk
f b arr
f b appbundle
f b bundle 
f b web
```

To build apk with split per abi, use this:

```bash
f bs apk
```

## Other Commands 

The list of other f commands that you can use to increase productivity with Flutter.

<table>
  <tr>
    <th>Command</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>f a -d DEVICE_ID</code></td>
    <td>Analyzes the project’s Dart source code.<br>Alias of <code>flutter analyze</code></td>
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