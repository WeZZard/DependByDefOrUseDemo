//
//  Common.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/13/24.
//

import SwiftUI
import Combine
import Observation


// MARK: - Data

enum Treat {
  case bone
  case frisbee
}

protocol DogProtocol {
  
  static var keyPath: WritableKeyPath<EnvironmentValues, Self> { get }
  
  var name: String { get }
  
  var happiness: Int { get }
  
  mutating func reward(_ treat: Treat)
  
}

struct Dog: DogProtocol, Equatable {
  
  static var keyPath: WritableKeyPath<EnvironmentValues, Self> {
    \.dog
  }
  
  var happiness: Int = 0

  var name: String = "Thor"
  
  mutating func reward(_ treat: Treat) {
    switch treat {
      case .bone:
        happiness += 3
      case .frisbee:
        happiness += 1
    }
  }

}

final class DogObject: DogProtocol, ObservableObject {
  
  class var keyPath: WritableKeyPath<EnvironmentValues, DogObject> {
    \.dogObject
  }
  
  @Published
  var happiness: Int = 0
  
  var name: String = "Thor"
  
  func reward(_ treat: Treat) {
    switch treat {
      case .bone:
        happiness += 3
      case .frisbee:
        happiness += 1
    }
  }

}

@Observable
final class DogObject2: DogProtocol {
  
  class var keyPath: WritableKeyPath<EnvironmentValues, DogObject2> {
    \.dogObject2
  }
  
  var happiness: Int = 0

  var name: String = "Thor"
  
  func reward(_ treat: Treat) {
    switch treat {
      case .bone:
        happiness += 3
      case .frisbee:
        happiness += 1
    }
  }

}

// MARK: - EnvironmentValues

enum Animal: Equatable {
  
  case dog
  
  case cat
  
  var name: String {
    switch self {
    case .dog:
      return "dog"
    case .cat:
      return "cat"
    }
  }
}

private struct ActiveAnimalKey: EnvironmentKey {
  
  static var defaultValue: Animal {
    return .dog
  }
  
}

private struct Counter1Key: EnvironmentKey {
  
  static var defaultValue: Int {
    return 0
  }
  
}

private struct Counter2Key: EnvironmentKey {
  
  static var defaultValue: Int {
    return 0
  }
  
}

extension EnvironmentValues {
  
  var animalOnTheStage: Animal {
    get {
      self[ActiveAnimalKey.self]
    }
    set {
      self[ActiveAnimalKey.self] = newValue
    }
  }
  
  var dogPawprints: Int {
    get {
      self[Counter1Key.self]
    }
    set {
      self[Counter1Key.self] = newValue
    }
  }
  
  var catPawprints: Int {
    get {
      self[Counter2Key.self]
    }
    set {
      self[Counter2Key.self] = newValue
    }
  }
  
}

extension EnvironmentValues {
  
  private struct DogKey: EnvironmentKey {
    
    typealias Value = Dog
    
    static var defaultValue: Dog {
      Dog()
    }
    
  }
  
  private struct DogObjectKey: EnvironmentKey {
    
    typealias Value = DogObject
    
    static var defaultValue: DogObject {
      DogObject()
    }
    
  }
  
  private struct DogObject2Key: EnvironmentKey {
    
    typealias Value = DogObject2
    
    static var defaultValue: DogObject2 {
      DogObject2()
    }
    
  }
  
  var dog: Dog {
    get {
      self[DogKey.self]
    }
    set {
      self[DogKey.self] = newValue
    }
  }
  
  var dogObject: DogObject {
    get {
      self[DogObjectKey.self]
    }
    set {
      self[DogObjectKey.self] = newValue
    }
  }
  
  var dogObject2: DogObject2 {
    get {
      self[DogObject2Key.self]
    }
    set {
      self[DogObject2Key.self] = newValue
    }
  }
  
}

// MARK: - Utilities

protocol DependencyExplaining {
  
  var dependencyType: String { get }
  
}

// MARK: - Views

struct PawView: View {
  
  var body: some View {
    Image(systemName: "pawprint.fill")
  }
  
}

struct ViewBodyProduceCounterView: View {
  
  private static var seed: Int = 0
  
  private class Store: ObservableObject {
    
    var count: Int = 0
    
  }
  
  @StateObject
  private var store: Store
  
  private var seed: Int
  
  init() {
    defer {
      Self.seed += 1
    }
    self._store = StateObject(wrappedValue: Store())
    self.seed = Self.seed
  }
  
  private func increase() {
    store.count += 1
  }
  
  var body: some View {
    let _ = increase()
    Group {
      Text(" x ") + Text(verbatim: store.count.description)
    }
    // Use onChange(of:, ...) to build a stable dependency that guarantees a
    // view body production.
    .onChange(of: seed) { oldValue, newValue in
      // do nothing
    }
  }
  
}
