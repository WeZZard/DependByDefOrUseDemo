//
//  Common.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/13/24.
//

import SwiftUI

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
