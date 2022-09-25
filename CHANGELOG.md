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
