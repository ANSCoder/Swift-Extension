# ``SwiftExtension``

Small, tested, dependency-free extensions for Foundation, UIKit and SwiftUI.

## Overview

Every helper is a single extension you can use on its own. The Foundation helpers build on every platform. The UIKit and SwiftUI helpers are compiled on platforms that provide UIKit.

```swift
import SwiftExtension

"john@example.com".isEmail                 // true
Date.now.adding(.day, value: 7)            // a week from now
Text("Saved").shake(trigger: attempts)     // SwiftUI
```

The repository also contains a catalog app with a live, playable example for each helper.

## Topics

### Strings and collections

- ``Swift/String``
- ``Swift/Array``
- ``Swift/Collection``
- ``Swift/Sequence``

### Dates, numbers and URLs

- ``Foundation/Date``
- ``Swift/Double``
- ``Swift/Comparable``
- ``Foundation/URL``
- ``Foundation/Bundle``
