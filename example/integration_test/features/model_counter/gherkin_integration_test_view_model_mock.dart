import 'package:example/gherkin_integration_test_view_model.dart';

class GherkinIntegrationTestViewModelMock
    extends GherkinIntegrationTestViewModel {
  @override
  void rebuild() {
    // Overriding this build method to avoid late initialising error of the (missing) setState method.
  }
}
