import 'dart:async';

void main() async {
  print('Starting async demo...');

  // Example 1: Basic Future
  print('1. Basic Future:');
  Future<String> futureMessage = getMessage();
  print('Future created, but not awaited yet.');
  String message = await futureMessage;
  print('Message: $message');

  // Example 2: Future with delay
  print('\n2. Future with delay:');
  await delayedPrint('Hello after 1 second');
  await delayedPrint('World after another 1 second');

  // Example 3: Multiple futures
  print('\n3. Multiple futures:');
  Future<String> future1 = fetchData('Data 1');
  Future<String> future2 = fetchData('Data 2');
  Future<String> future3 = fetchData('Data 3');

  List<String> results = await Future.wait([future1, future2, future3]);
  print('All results: $results');

  // Example 4: Error handling
  print('\n4. Error handling:');
  try {
    await riskyOperation(true); // succeeds
    await riskyOperation(false); // fails
  } catch (e) {
    print('Caught error: $e');
  }

  print('\nAsync demo complete!');
}

// Basic Future function
Future<String> getMessage() async {
  // Simulate some work
  await Future.delayed(Duration(milliseconds: 500));
  return 'Hello from the future!';
}

// Future with delay and print
Future<void> delayedPrint(String message) async {
  await Future.delayed(Duration(seconds: 1));
  print('Delayed: $message');
}

// Simulate fetching data
Future<String> fetchData(String data) async {
  await Future.delayed(Duration(milliseconds: 200 + data.length * 100));
  return '$data fetched';
}

// Risky operation that might fail
Future<String> riskyOperation(bool succeed) async {
  await Future.delayed(Duration(milliseconds: 300));
  if (!succeed) {
    throw Exception('Operation failed!');
  }
  return 'Operation succeeded!';
}