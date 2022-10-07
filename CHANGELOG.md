## 0.0.4+4

* Improved example project

## 0.0.4+3

* Improved example toString again

## 0.0.4+2

* Improved example toString

## 0.0.4+1

* Removed unused UnitExample.isLastExample.

## 0.0.4

* **⚠️ Breaking:** Added the `IntegrationMocks` object that gets passed around from your setup methods until your last `IntegrationStep` to facilitate better mocks integration.
* **⚠️ Breaking:** All set up methods (`setUpEach`, `setUpOnce`, `tearDownEach` and `tearDownOnce`) inside all parent classes (`IntegrationTest`, `IntegrationFeature` and `IntegrationScenario`) will now have access to the new `IntegrationMocks` object.

## 0.0.3

* **⚠️ Breaking:** Replaces the `result` parameter (now `box`) of the `IntegrationStepCallback` with an instance of `IntegrationBox`. This will allow you to save multiple persistent values throughout a series of steps inside the `box` instead of passing around a maximum of one single value as a `result` through multiple steps.
* **⚠️ Breaking:** Removed the recently introduces extension methods for cast a result since `result` has now been replaces with the new `IntegrationBox` which has this functionality built in.

## 0.0.2+3

* Added `asType` and `asNullableType` extension methods for easier usage of an `IntegrationStep`'s result.

## 0.0.2+2

* **🐛️ Bugfix:** Fix passing around result bug

## 0.0.2+1

* Fix readme

## 0.0.2

* **⚠️ Breaking:** Added generic argument to scenario for easier example usage.
* Update readme

## 0.0.1+3

* Remove `required` from the `IntegrationExample.values` field.

## 0.0.1+2

* Updated info icon.

## 0.0.1

* Initial release.
