# Typo

Type safe UserDefaults wrapper

# Usage

Define your namespaces

```swift
import Typo

enum Global: NamespaceTag {}
enum Nested: NamespaceTag {}
```

Define properties (and nested namespaces)

```swift
extension Namespace where Tag == Global {
  var nestedNS: Namespace<Nested> { .init() }
  var intProperty: Property<Int> { .init(default: .zero) }
}

extension Namespace where Tag == Nested {
  var stringProperty: Property<String> { .init(default: "") }
}
```

Create StorageProxy
```swift
let proxy = StorageProxy(
  namespaceTag: Global.self,
  storage: UserDefaults.standard
)
```

Use the proxy to access your properties
```swift
let int = proxy.intProperty
let string = proxy.nestedNS.stringProperty
```

# Using custom types
To store your types, implement Value protocol
```swift
public protocol Value: Codable {
    static var typeIdentifier: String { get }
}
```
`typeIdentifier` is used to preserve type information when encoding values

# Customization
You can customize keys using `StorageProxy` initializer

```swift
StorageProxy(
  namespaceTag: ,
  storage: ,
  keyPrefix: ,
  keyTransformation:
)
```

# Included, but not limited to UserDefauls
If you want Typo to use other types of storages, just implement Storage protocol
```swift
public protocol Storage: AnyObject {
    subscript(_ key: String) -> Data? { get set }
}
```
This way you can make any type of key-value storage to be compatible with typo (plain dictionary, NSCache, KeyChain, CoreData, etc)

# Migrations
Your app data and it's structure may (and will) evolve over time. Typo provides mechanism to add migrations to properties
```swift
extension Namespace where Tag == Global {
  var intProperty: Property<Int> {
    Property(default: 0)
      .migration(
        Migration(initialType: Double.self)
          .migrate {
            Int(exactly: $0) ?? 0
          }
      )
  }
}
```

# Getting keys
In case you need to get keys for your properties (e.g. your storage has some kind of observing), you can call the StorageProxy to get KeyKeeper object and use it the same way you use proxy to get keys for the properties insted of values
```swift
let proxy = StorageProxy(
  namespaceTag: Global.self,
  storage: UserDefaults.standard
)

print(proxy().nestedNS.stringProperty) // "nestedNS/stringProperty"
```

# Contribute
Feel free to open an issue or pull-request
