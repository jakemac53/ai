---
name: persist-data-with-sqlite
description: How to use SQLite to store and retrieve data.
metadata:
  url: https://docs.flutter.dev/cookbook/persistence/sqlite
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Persist data with SQLite

infoNote

This guide uses the [sqflite package](https://pub.dev/packages/sqflite).
This package only supports apps that run on
macOS, iOS, or Android.


If you are writing an app that needs to persist and query large amounts of data on
the local device, consider using a database instead of a local file or
key-value store. In general, databases provide faster inserts, updates,
and queries compared to other local persistence solutions.


Flutter apps can make use of the SQLite databases via the
[`sqflite`](https://pub.dev/packages/sqflite) plugin available on pub.dev.
This recipe demonstrates the basics of using `sqflite`
to insert, read, update, and remove data about various Dogs.


If you are new to SQLite and SQL statements, review the
[SQLite Tutorial](https://www.sqlitetutorial.net/) to learn the basics before
completing this recipe.


This recipe uses the following steps:

1. Add the dependencies.
2. Define the `Dog` data model.
3. Open the database.
4. Create the `dogs` table.
5. Insert a `Dog` into the database.
6. Retrieve the list of dogs.
7. Update a `Dog` in the database.
8. Delete a `Dog` from the database.

## 1\. Add the dependencies

[#](#1-add-the-dependencies)

To work with SQLite databases, import the `sqflite` and
`path` packages.


- The `sqflite` package provides classes and functions to
   interact with a SQLite database.

- The `path` package provides functions to
   define the location for storing the database on disk.


To add the packages as a dependency,
run `flutter pub add`:


```
$ flutter pub add sqflite path

```

content\_copy

Make sure to import the packages in the file you'll be working in.

dart

```
import 'dart:async';
​
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

```

content\_copy

## 2\. Define the Dog data model

[#](#2-define-the-dog-data-model)

Before creating the table to store information on Dogs, take a few moments to
define the data that needs to be stored. For this example, define a Dog class
that contains three pieces of data:
A unique `id`, the `name`, and the `age` of each dog.


dart

```
class Dog {
  final int id;
  final String name;
  final int age;
​
  const Dog({required this.id, required this.name, required this.age});
}

```

content\_copy

## 3\. Open the database

[#](#3-open-the-database)

Before reading and writing data to the database, open a connection
to the database. This involves two steps:


1. Define the path to the database file using `getDatabasesPath()` from the
    `sqflite` package, combined with the `join` function from the
    `path` package.

2. Open the database with the `openDatabase()` function from `sqflite`.

infoNote

In order to use the keyword `await`, the code must be placed
inside an `async` function. You should place all the following
table functions inside `void main() async {}`.


dart

```
// Avoid errors caused by flutter upgrade.
// Importing 'package:flutter/widgets.dart' is required.
WidgetsFlutterBinding.ensureInitialized();
// Open the database and store the reference.
final database = openDatabase(
  // Set the path to the database. Note: Using the `join` function from the
  // `path` package is best practice to ensure the path is correctly
  // constructed for each platform.
  join(await getDatabasesPath(), 'doggie_database.db'),
);

```

content\_copy

## 4\. Create the `dogs` table

[#](#4-create-the-dogs-table)

Next, create a table to store information about various Dogs.
For this example, create a table called `dogs` that defines the data
that can be stored. Each `Dog` contains an `id`, `name`, and
`age`.
Therefore, these are represented as three columns in the `dogs` table.


1. The `id` is a Dart `int`, and is stored as an `INTEGER` SQLite
    Datatype. It is also good practice to use an `id` as the primary
    key for the table to improve query and update times.

2. The `name` is a Dart `String`, and is stored as a `TEXT` SQLite
    Datatype.

3. The `age` is also a Dart `int`, and is stored as an `INTEGER`
    Datatype.


For more information about the available Datatypes that can be stored in a
SQLite database, see the [official SQLite Datatypes documentation](https://www.sqlite.org/datatype3.html).


dart

```
final database = openDatabase(
  // Set the path to the database. Note: Using the `join` function from the
  // `path` package is best practice to ensure the path is correctly
  // constructed for each platform.
  join(await getDatabasesPath(), 'doggie_database.db'),
  // When the database is first created, create a table to store dogs.
  onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
      'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
    );
  },
  // Set the version. This executes the onCreate function and provides a
  // path to perform database upgrades and downgrades.
  version: 1,
);

```

content\_copy

## 5\. Insert a Dog into the database

[#](#5-insert-a-dog-into-the-database)

Now that you have a database with a table suitable for storing information
about various dogs, it's time to read and write data.


First, insert a `Dog` into the `dogs` table. This involves two steps:

1. Convert the `Dog` into a `Map`
2. Use the [`insert()`](https://pub.dev/documentation/sqflite_common/latest/sqlite_api/DatabaseExecutor/insert.html)
    method to store the
    `Map` in the `dogs` table.


dart

```
class Dog {
  final int id;
  final String name;
  final int age;
​
  Dog({required this.id, required this.name, required this.age});
​
  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }
​
  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}

```

content\_copy

dart

```
// Define a function that inserts dogs into the database
Future<void> insertDog(Dog dog) async {
  // Get a reference to the database.
  final db = await database;
​
  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'dogs',
    dog.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

```

content\_copy

dart

```
// Create a Dog and add it to the dogs table
var fido = Dog(id: 0, name: 'Fido', age: 35);
​
await insertDog(fido);

```

content\_copy

## 6\. Retrieve the list of Dogs

[#](#6-retrieve-the-list-of-dogs)

Now that a `Dog` is stored in the database, query the database
for a specific dog or a list of all dogs. This involves two steps:


1. Run a `query` against the `dogs` table. This returns a `List<Map>`.

2. Convert the `List<Map>` into a `List<Dog>`.

dart

```
// A method that retrieves all the dogs from the dogs table.
Future<List<Dog>> dogs() async {
  // Get a reference to the database.
  final db = await database;
​
  // Query the table for all the dogs.
  final List<Map<String, Object?>> dogMaps = await db.query('dogs');
​
  // Convert the list of each dog's fields into a list of `Dog` objects.
  return [
    for (final {'id': id as int, 'name': name as String, 'age': age as int}
        in dogMaps)
      Dog(id: id, name: name, age: age),
  ];
}

```

content\_copy

dart

```
// Now, use the method above to retrieve all the dogs.
print(await dogs()); // Prints a list that include Fido.

```

content\_copy

## 7\. Update a `Dog` in the database

[#](#7-update-a-dog-in-the-database)

After inserting information into the database,
you might want to update that information at a later time.
You can do this by using the [`update()`](https://pub.dev/documentation/sqflite_common/latest/sqlite_api/DatabaseExecutor/update.html)

method from the `sqflite` library.


This involves two steps:

1. Convert the Dog into a Map.
2. Use a `where` clause to ensure you update the correct Dog.

dart

```
Future<void> updateDog(Dog dog) async {
  // Get a reference to the database.
  final db = await database;
​
  // Update the given Dog.
  await db.update(
    'dogs',
    dog.toMap(),
    // Ensure that the Dog has a matching id.
    where: 'id = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [dog.id],
  );
}

```

content\_copy

dart

```
// Update Fido's age and save it to the database.
fido = Dog(id: fido.id, name: fido.name, age: fido.age + 7);
await updateDog(fido);
​
// Print the updated results.
print(await dogs()); // Prints Fido with age 42.

```

content\_copy

warningWarning

Always use `whereArgs` to pass arguments to a `where` statement.
This helps safeguard against SQL injection attacks.


Do not use string interpolation, such as `where: "id = ${dog.id}"`!

## 8\. Delete a `Dog` from the database

[#](#8-delete-a-dog-from-the-database)

In addition to inserting and updating information about Dogs,
you can also remove dogs from the database. To delete data,
use the [`delete()`](https://pub.dev/documentation/sqflite_common/latest/sqlite_api/DatabaseExecutor/delete.html)
method from the `sqflite` library.


In this section, create a function that takes an id and deletes the dog with
a matching id from the database. To make this work, you must provide a `where`

clause to limit the records being deleted.


dart

```
Future<void> deleteDog(int id) async {
  // Get a reference to the database.
  final db = await database;
​
  // Remove the Dog from the database.
  await db.delete(
    'dogs',
    // Use a `where` clause to delete a specific dog.
    where: 'id = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}

```

content\_copy

## Example

[#](#example)

To run the example:

1. Create a new Flutter project.
2. Add the `sqflite` and `path` packages to your `pubspec.yaml`.
3. Paste the following code into a new file called `lib/db_test.dart`.
4. Run the code with `flutter run lib/db_test.dart`.

dart

```
import 'dart:async';
​
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
​
void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'doggie_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );
​
  // Define a function that inserts dogs into the database
  Future<void> insertDog(Dog dog) async {
    // Get a reference to the database.
    final db = await database;
​
    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
​
  // A method that retrieves all the dogs from the dogs table.
  Future<List<Dog>> dogs() async {
    // Get a reference to the database.
    final db = await database;
​
    // Query the table for all the dogs.
    final List<Map<String, Object?>> dogMaps = await db.query('dogs');
​
    // Convert the list of each dog's fields into a list of `Dog` objects.
    return [
      for (final {'id': id as int, 'name': name as String, 'age': age as int}
          in dogMaps)
        Dog(id: id, name: name, age: age),
    ];
  }
​
  Future<void> updateDog(Dog dog) async {
    // Get a reference to the database.
    final db = await database;
​
    // Update the given Dog.
    await db.update(
      'dogs',
      dog.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }
​
  Future<void> deleteDog(int id) async {
    // Get a reference to the database.
    final db = await database;
​
    // Remove the Dog from the database.
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
​
  // Create a Dog and add it to the dogs table
  var fido = Dog(id: 0, name: 'Fido', age: 35);
​
  await insertDog(fido);
​
  // Now, use the method above to retrieve all the dogs.
  print(await dogs()); // Prints a list that include Fido.
​
  // Update Fido's age and save it to the database.
  fido = Dog(id: fido.id, name: fido.name, age: fido.age + 7);
  await updateDog(fido);
​
  // Print the updated results.
  print(await dogs()); // Prints Fido with age 42.
​
  // Delete Fido from the database.
  await deleteDog(fido.id);
​
  // Print the list of dogs (empty).
  print(await dogs());
}
​
class Dog {
  final int id;
  final String name;
  final int age;
​
  Dog({required this.id, required this.name, required this.age});
​
  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }
​
  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}

```

content\_copy

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/persistence/sqlite.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/persistence/sqlite&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/persistence/sqlite.md "Report an issue with this page").