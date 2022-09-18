echo 'flutter: [✉] --- TEST LOG --- [💡] Moving to root..'
cd ..
echo 'flutter: [✉] --- TEST LOG --- [💡] Moved to root! Current dir:'
pwd
echo 'flutter: [✉] --- TEST LOG --- [💡] Running integration tests..'
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/example_integration_test.dart
echo 'flutter: [✉] --- TEST LOG --- [💡] Done running integrations tests!'
