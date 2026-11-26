import 'package:flutter_test/flutter_test.dart';
import 'package:personal_intelligence/main.dart';

void main() {
  testWidgets('FilteredHealth app opens with its demo home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const FilteredHealthApp());

    expect(find.text('Your health,\nin context.'), findsOneWidget);
    expect(find.text('DEMO MODE  •  SAMPLE DATA'), findsOneWidget);
  });
}
