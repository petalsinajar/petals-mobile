import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/features/auth/domain/handles.dart';

void main() {
  group('suggestHandle mirrors the backend', () {
    test('joins words with dots, lowercased', () {
      expect(suggestHandle('Ama Mensah'), 'ama.mensah');
    });

    test('drops accents and symbols', () {
      expect(suggestHandle("Ẹ̀fúà  O'Brien-Addo!"), 'efua.o.brien.addo');
    });

    test('caps the length at 24', () {
      expect(suggestHandle('a' * 40), 'a' * 24);
    });

    test('pads names that are too short', () {
      expect(suggestHandle('Al'), 'useral');
      expect(suggestHandle('!!'), 'user');
    });
  });

  group('handleProblem', () {
    test('accepts valid handles, with or without @ and in any case', () {
      for (final h in ['ama.mensah', '@Ama_Mensah', 'abc', 'a1.b2']) {
        expect(handleProblem(h), isNull, reason: h);
      }
    });

    test('rejects the shapes the backend rejects', () {
      for (final h in [
        'ab', // too short
        '.ama', // starts with a symbol
        'ama.', // ends with a symbol
        'ama..mensah', // double dot
        'ama mensah', // space
        'a' * 31, // too long
        'admin', // reserved
      ]) {
        expect(handleProblem(h), isNotNull, reason: h);
      }
    });
  });
}
