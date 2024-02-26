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

struct Dog: Equatable {

  var happyValue: Int = 0

  mutating func reward(_ treat: Treat) {
    switch treat {
      case .bone:
        happyValue += 3
      case .frisbee:
        happyValue += 1
    }
  }

}

class DogObject: ObservableObject {

  @Published
  var happyValue: Int = 0

  func reward(_ treat: Treat) {
    switch treat {
      case .bone:
        happyValue += 3
      case .frisbee:
        happyValue += 1
    }
  }

}

@Observable
class DogObject2 {

  var happyValue: Int = 0

  func reward(_ treat: Treat) {
    switch treat {
      case .bone:
        happyValue += 3
      case .frisbee:
        happyValue += 1
    }
  }

}

// MARK: - EnvironmentValues

enum ActiveCounter: Equatable {
  case counter1
  case counter2
  
  var name: String {
    switch self {
    case .counter1:
      "1"
    case .counter2:
      "2"
    }
  }
}

private struct ActiveCounterKey: EnvironmentKey {
  
  static var defaultValue: ActiveCounter {
    .counter1
  }
  
}

private struct Counter1Key: EnvironmentKey {
  
  static var defaultValue: Int {
    0
  }
  
}

private struct Counter2Key: EnvironmentKey {
  
  static var defaultValue: Int {
    0
  }
  
}

extension EnvironmentValues {
  
  var activeCounter: ActiveCounter {
    get {
      self[ActiveCounterKey.self]
    }
    set {
      self[ActiveCounterKey.self] = newValue
    }
  }
  
  var counter1: Int {
    get {
      self[Counter1Key.self]
    }
    set {
      self[Counter1Key.self] = newValue
    }
  }
  
  var counter2: Int {
    get {
      self[Counter2Key.self]
    }
    set {
      self[Counter2Key.self] = newValue
    }
  }
  
}

extension EnvironmentValues {
  
  private struct Key: EnvironmentKey {
    
    typealias Value = Dog
    
    static var defaultValue: Dog {
      Dog()
    }
    
  }
  
  var dog4: Dog {
    get {
      self[Key.self]
    }
    set {
      self[Key.self] = newValue
    }
  }
  
}

// MARK: - Utilities

protocol DependencyExplaining {
  
  static var dependencyType: String { get }
  
}

// MARK: - Views

struct PawView: View {
  
  var body: some View {
    Image(systemName: "pawprint.fill")
  }
  
}

struct ViewBodyProduceCounterView: View {
  
  fileprivate static func clear() {
    counter = 0
  }
  
  private static var counter: Int = 0
  
  let counter: Int
  
  init() {
    Self.counter += 1
    self.counter = Self.counter
  }
  
  var body: some View {
    Text(" x ") + Text(verbatim: counter.description)
  }
  
}


extension View {
  
  func clearViewBodyProduceCount() -> some View {
    onDisappear {
      ViewBodyProduceCounterView.clear()
    }
  }
  
}
