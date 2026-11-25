
import 'package:flutter_test/flutter_test.dart';
import 'package:my_books/main.dart';

void main() {
  testWidgets('Book Library test', (WidgetTester tester) async {

    await tester.pumpWidget(const BookApp());
    expect(find.textContaining('կարդացված'), findsOneWidget);
    expect(find.text('Անուշ'), findsOneWidget);
    expect(find.text('Սամվել'), findsOneWidget);
    expect(find.text('Գիքոր'), findsOneWidget);
    expect(
      find.text('Որոնել գիրք կամ հեղինակ...'),
      findsOneWidget,
    );
  });
}
