---
name: create-a-new-flutter-app
description: Learn how to bootstrap a new Flutter application from your command-line, different editors, and even in the cloud.
metadata:
  url: https://docs.flutter.dev/reference/create-new-app
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Create a new Flutter app

This page provides step-by-step instructions on how to
bootstrap a new Flutter app in your preferred development environment.


To create a new Flutter app, first [set up Flutter](/get-started), then
choose your preferred environment and follow the corresponding instructions.


[VS Code\
\
Create a new Flutter app without leaving VS Code.](#vs-code) [Android Studio\
\
Create a new Flutter app without leaving Android Studio.](#android-studio) [IntelliJ\
\
Create a new Flutter app without leaving your IntelliJ-based IDE.](#intellij) [Firebase Studio\
\
For quick and easy setup, create a new Flutter app in Firebase Studio.](#firebase-studio) [Terminal\
\
For maximum flexibility, create a new Flutter app from the command line.](#terminal) [Add to appopen\_in\_new\
\
Create a new Flutter module to embed in an existing app.](/add-to-app#get-started)

## VS Code

[#](#vs-code)

To create a Flutter app with [VS Code](https://code.visualstudio.com/) and other Code OSS-based editors,
you first need to [install Flutter](/get-started) and
[set up VS Code](/tools/vs-code#installation-and-setup) for Flutter development.
Then follow these steps:


1. ### Launch VS Code


   Open VS Code or your preferred Code OSS-based editor.

2. ### Open the command palette


   Go to **View** > **Command Palette** or
    press `Cmd/Ctrl` +
    `Shift` \+ `P`.

3. ### Find the Flutter commands


   In the command palette, start typing `flutter:`.
    VS Code should surface commands from the Flutter plugin.

4. ### Run the new project command


   Select the **Flutter: New Project** command.
    Your OS or VS Code might ask for access to your documents,
    agree to continue to the next step.

5. ### Choose a template


   VS Code should prompt you with **Which Flutter template?**.
    Depending on what type of Flutter project you want to create,
    choose the corresponding template.
    For a new Flutter app, choose **Application**.

6. ### Select a project location


   A file dialog should appear.
    Select or create the parent directory where
    you want the project to be created.
    Don't create the project folder itself, the Flutter tool does so.
    To confirm your selection,
    click **Select a folder to create the project in**.

7. ### Enter a project name


   VS Code should prompt you to enter a name for your new project.
    Enter a name for your app that follows the `lowercase_with_underscores`

    naming convention, following the [Effective Dart](https://dart.dev/effective-dart/style#do-name-packages-and-file-system-entities-using-lowercase-with-underscores)
    guidelines.
    To confirm your selection, press `Enter`.

8. ### Wait for project initialization


   Based on the information you entered,
    VS Code uses `flutter create` to bootstrap your app.
    Progress is often surfaced as a notification in the bottom right
    and can also be accessed from the **Output** panel.

9. ### Run your app


   Your new app should now be created and open in VS Code.
    To try your new app,
    follow the steps to [run and debug](/tools/vs-code#running-and-debugging)
    in VS Code.


You've successfully created a new Flutter app in VS Code!
If you need more help with developing Flutter in VS Code,
check out the [VS Code for Flutter reference](/tools/vs-code).


## Android Studio

[#](#android-studio)

To create a Flutter app with Android Studio,
you first need to [install Flutter](/get-started) and
[set up Android Studio](/tools/android-studio#installation-and-setup) for Flutter development.
Then follow these steps:


1. ### Launch Android Studio


   Open Android Studio with the Dart and Flutter plugins installed.

2. ### Begin project creation


   If you're on the IDE welcome dialog that says **Welcome to Android Studio**,
    find and click the **New Flutter Project** button in the center.

   If you already have a project open, either close it or
    go to **File** > **New** > **New Flutter Project...**.

3. ### Choose a project type


   In the **New Project** dialog, under **Generators** in the left panel,
    select **Flutter**.

4. ### Verify Flutter SDK setup


   At the top of the right panel, ensure the **Flutter SDK path** value matches
    the location of the Flutter SDK you'd like to develop with.
    If not, update it by choosing or specifying the correct one.

5. ### Configure your project


   Click **Next** to continue to project configuration.
    Multiple configuration options should appear.

   In the **Project name** field, enter a name for your app that
    follows the `lowercase_with_underscores` naming convention,
    following the [Effective Dart](https://dart.dev/effective-dart/style#do-name-packages-and-file-system-entities-using-lowercase-with-underscores)
    guidelines.

   If you're not creating an application,
    select another template from the **Project type** dropdown.

   If you're creating an app that you might publish in the future,
    set the **Organization** field [to your company domain](/tools/android-studio#set-the-company-domain).

   The other fields can be kept as is or
    configured according to your project's needs.

6. ### Finish project creation


   Once you've completed the configuration of your project,
    click **Create** to begin project initialization.

7. ### Wait for workspace initialization


   Android Studio will now initialize your workspace,
    bootstrap your project file structure,
    and retrieve your app's dependencies.
    This might take a while and can be tracked at the bottom of the window.

8. ### Run your app


   Your new app should now be created and open in Android Studio.
    To try your new app,
    follow the steps to [run and debug](/tools/android-studio#running-and-debugging)
    in Android Studio.


You've successfully created a new Flutter app in Android Studio!
If you need more help with developing Flutter in Android Studio,
check out the [Android Studio for Flutter reference](/tools/android-studio).


## IntelliJ

[#](#intellij)

To create a Flutter app with IntelliJ or other JetBrains IDEs,
you first need to [install Flutter](/get-started) and
[set up IntelliJ](/tools/android-studio#installation-and-setup) for Flutter development.
Then follow these steps:


1. ### Launch IntelliJ


   Open IntelliJ IDEA or your preferred IntelliJ-based IDE by JetBrains
    that has the Dart and Flutter plugins installed.

2. ### Begin project creation


   If you're on the IDE welcome dialog that says **Welcome to IntelliJ IDEA**,
    find and click the **New Project** button in the upper right corner.

   If you already have a project open, either close it or
    go to **File** > **New** > **New Project...**.

3. ### Choose a project type


   In the **New Project** dialog, under **Generators** in the left panel,
    select **Flutter**.

4. ### Verify Flutter SDK setup


   At the top of the right panel, ensure the **Flutter SDK path** value matches
    the location of the Flutter SDK you'd like to develop with.
    If not, update it by choosing or specifying the correct one.

5. ### Configure your project


   Click **Next** to continue to project configuration.
    Multiple configuration options should appear.

   In the **Project name** field, enter a name for your app that
    follows the `lowercase_with_underscores` naming convention,
    following the [Effective Dart](https://dart.dev/effective-dart/style#do-name-packages-and-file-system-entities-using-lowercase-with-underscores)
    guidelines.

   If you're not creating an application,
    select another template from the **Project type** dropdown.

   If you're creating an app that you might publish in the future,
    set the **Organization** field \[to your company domain\]\[ij-set-org\].

   The other fields can be kept as is or
    configured according to your project's needs.

6. ### Finish project creation


   Once you've completed the configuration of your project,
    click **Create** to begin project initialization.

7. ### Wait for workspace initialization


   IntelliJ will now initialize your workspace,
    bootstrap your project file structure,
    and retrieve your app's dependencies.
    This might take a while and can be tracked at the bottom of the window.

8. ### Run your app


   Your new app should now be created and open in IntelliJ.
    To try your new app,
    follow the steps to [run and debug](/tools/android-studio#running-and-debugging)
    in IntelliJ.


You've successfully created a new Flutter app in IntelliJ!
If you need more help with developing Flutter in IntelliJ,
check out the [IntelliJ for Flutter reference](/tools/android-studio).


## Firebase Studio

[#](#firebase-studio)

To create a Flutter app with [Firebase Studio](https://firebase.studio),
you first need a Google account and to [set up Firebase Studio](https://firebase.google.com/docs/studio/get-started).
Then follow these steps:


1. ### Launch Firebase Studio


   In your preferred browser, navigate to the [Firebase Studio dashboard](https://studio.firebase.google.com/)

    found at `studio.firebase.google.com/`.
    If you haven't yet, you might need to log in to your Google account.

2. ### Create a new workspace


   In the Firebase Studio dashboard, find the **Start coding an app** section.
    It should include a variety of templates to choose from.
    Select the **Flutter** template.
    If you can't find it, it might be under a **Mobile** category.

3. ### Name your workspace


   Firebase Studio should prompt you to **Name your workspace**.
    This name is distinct from the name of your Flutter app.
    Choose a descriptive name that you'll recognize
    in a list of your workspaces.

4. ### Provision your new workspace


   Once you've chosen a name and configured your workspace,
    click **Create** to provision your new workspace.

5. ### Wait for workspace initialization


   Firebase Studio will now initialize your workspace,
    bootstrap your project file structure,
    and retrieve your app's dependencies.
    This might take a while.

6. ### Run your app


   Your new app should now be created and opened in the Firebase Studio editor.
    To try your new app, follow the docs provided by Firebase Studio to
    [preview your app](https://firebase.google.com/docs/studio/preview-apps)
    on the web or on Android.


You've successfully created a new Flutter app in Firebase Studio!
If you need help configuring your workspace,
check out [Customize your Firebase studio workspace](https://firebase.google.com/docs/studio/customize-workspace).


## Terminal

[#](#terminal)

To create a Flutter app in your terminal,
you first need to install and [set up Flutter](/get-started).
Then follow these steps:


1. ### Open your terminal


   Open your preferred method to access the command line,
    such as Terminal on macOS or PowerShell on Windows.

2. ### Navigate to the desired directory


   Ensure your current working directory
    is the desired parent directory for your new app.
    Don't create the project folder, the `flutter` tool will do so.

3. ### Configure project creation


   In your terminal, type out the `flutter create` command and
    pass in any desired flags and options to configure your project.
    For example, to create an app with a minimal `main.dart` file,
    you can add the `--empty` option:





   ```
   $ flutter create --empty

   ```

   content\_copy



   To learn about the available creation options,
    run `flutter create --help` in another terminal window.

4. ### Enter a project name


   As the only non-option argument to `flutter create`,
    specify the directory and default name for your application.
    The name should follow the `lowercase_with_underscores` naming convention,
    following the [Effective Dart](https://dart.dev/effective-dart/style#do-name-packages-and-file-system-entities-using-lowercase-with-underscores)
    guidelines.

   For example, if you wanted to create an app named `my_app`:





   ```
   $ flutter create my_app

   ```

   content\_copy

5. ### Execute the configured command


   To create a project with your specified configuration,
    run the command you built in the previous step.

6. ### Wait for project initialization


   The `flutter` tool will now bootstrap your project's file structure
    and retrieve any necessary dependencies.
    This might take a while.

7. ### Navigate into the project directory


   Now that your project has been created,
    you can navigate to it in your terminal or your preferred editor.
    For example, with a bash shell and a project named `my_app`:





   ```
   $ cd my_app

   ```

   content\_copy

8. ### Run your app


   To try your new app,
    run the `flutter run` command in your terminal and
    respond to its prompts to select an output device.


You've successfully created a new Flutter app in your terminal!
If you need help configuring your project or with the `flutter` CLI tool,
check out the [Flutter CLI reference](/reference/flutter-cli).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-12-8. [View source](https://github.com/flutter/website/blob/main/src/content/reference/create-new-app.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/reference/create-new-app&page-source=https://github.com/flutter/website/blob/main/src/content/reference/create-new-app.md "Report an issue with this page").