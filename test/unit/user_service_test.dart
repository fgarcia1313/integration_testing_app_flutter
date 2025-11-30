import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_testing_app_flutter/repositories/user_repository.dart';
import 'package:integration_testing_app_flutter/services/user_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

class MockUserService extends Mock implements UserService {}

class FakeUri extends Fake implements Uri {}

void main() {
  late MockHttpClient mockClient;
  late UserService service;
  late MockUserService mockService;
  late UserRepository repo;

  setUp(() {
    registerFallbackValue(FakeUri());
    mockClient = MockHttpClient();
    service = UserService(mockClient);
    mockService = MockUserService();
    repo = UserRepository(mockService);
  });

  /*
  setUpAll() {
    registerFallbackValue(FakeUri());
    mockClient = MockHttpClient();
    service = UserService(mockClient);
  }
  */

  test('fetchUsers retorna lista cuando server responde 200', () async {
    final fakeResponse = http.Response('[{"name": "Fernando"}, {"name": "Juan"}]', 200);

    when(() => mockClient.get(any())).thenAnswer((_) async => fakeResponse);

    final users = await service.fetchUsers();

    expect(users.length, 2);
    verify(() => mockClient.get(any())).called(1);
  });

  test('fetchUsers lanza excepcion cuando server responde 500', () async {
    when(() => mockClient.get(any())).thenAnswer((_) async => http.Response('Error', 500));

    expect(() => service.fetchUsers(), throwsException);
  });

  test('fetchUsers lanza excepcion en timeout', () async {
    when(() => mockClient.get(any())).thenThrow(TimeoutException('timeout'));

    expect(() => service.fetchUsers(), throwsA(isA<TimeoutException>()));
  });

  test('fetchUsers con latencia', () async {
    when(() => mockClient.get(any())).thenAnswer((_) async {
      final fakeResponse = http.Response('[{"name": "Fernando"}, {"name": "Juan"}]', 200);
      await Future.delayed(const Duration(milliseconds: 500));
      return fakeResponse;
    });

    final users = await service.fetchUsers();
    expect(users.length, 2);
    verify(() => mockClient.get(any())).called(1);
  });

  test('getUserNames retorna lista de nombres', () async {
    when(() => mockService.fetchUsers()).thenAnswer(
      (_) async => [
        {'name': 'Fer'},
        {'name': 'Juan'},
      ],
    );

    final names = await repo.getUserNames();

    expect(names, ['Fer', 'Juan']);
    verify(() => mockService.fetchUsers()).called(1);
  });

  test('getUserNames retorna lista vacia', () async {
    when(() => mockService.fetchUsers()).thenAnswer((_) async => []);
    final names = await repo.getUserNames();

    expect(names.length, 0);
    verify(() => mockService.fetchUsers()).called(1);
  });

  test('getUserNames retorna Exception', () async {
    when(() => mockService.fetchUsers()).thenThrow(Exception());

    expect(() => repo.getUserNames(), throwsA(isA<Exception>()));
  });
}
