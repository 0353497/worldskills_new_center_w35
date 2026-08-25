import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:worldskills_new_center/main.dart';

void main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  int currentStep = 1;
  nextStep(String description) async {
    print("Step No: $currentStep, $description,");
    await Future.delayed(1.seconds);
    currentStep++;
  }

  testWidgets("WorldSkill News Center", (tester) async {
    await nextStep("Application Startup");
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    await nextStep("Open drawer menu by clicking the menu button");
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await nextStep(
      'Click the skill type "Information and Communication Technology"',
    );
    await tester.tap(find.text("Information and Communication Technology"));
    await tester.pumpAndSettle();

    await nextStep(
      'Show the Information Network Cabling News List by clicking "Information Network Cabling"',
    );
    await tester.tap(find.text("Information Network Cabling"));
    await tester.pumpAndSettle();

    await nextStep(
      'Scroll the news list until there appears a piece of news with the title including "London"',
    );
    await tester.scrollUntilVisible(find.textContaining("London"), 500);
    await tester.pumpAndSettle();

    await nextStep("Open drawer menu by clicking the menu button");
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await nextStep('Click "Search Now" Button');
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    await nextStep('Input text into the Input box of the news title');
    await tester.enterText(find.byKey(ValueKey("news_title")), "web");
    await tester.pumpAndSettle();

    await nextStep('Input text into the Input box of skill');
    await tester.enterText(find.byKey(ValueKey("skill_name")), "Mobile");
    await tester.pumpAndSettle();

    await nextStep(
      'Input start date and end date into the input boxes of date ',
    );
    await tester.enterText(find.byKey(ValueKey("date_start")), "03/21/2022");
    await tester.enterText(find.byKey(ValueKey("date_end")), "09/30/2022");
    await tester.pumpAndSettle();

    await nextStep('Click the search icon button');
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    await nextStep('Scroll the news list until the tenth news appears');
    await tester.scrollUntilVisible(find.textContaining("Earn web"), 500);
    await tester.pumpAndSettle();

    await nextStep('Click the tenth news');
    await tester.tap(find.textContaining("Earn web"));
    await tester.pumpAndSettle();

    await nextStep('Click the "+" Button');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await nextStep('Click the close icon button');
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
  });
}
