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
  
  private struct Key: EnvironmentKey {
    
    typealias Value = Dog
    
    static var defaultValue: Dog {
      Dog()
    }
    
  }
  
  var dog: Dog {
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
