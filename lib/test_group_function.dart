import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin_integration_test/gherkin_integration_test.dart';

/// Used as a signature for test methods [setUp], [setUpAll], [tearDown] and [tearDownAll].
typedef TestGroupFunction = FutureOr Function(IntegrationMocks mocks);
