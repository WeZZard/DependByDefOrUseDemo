//
//  DogView.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 3/4/24.
//

import SwiftUI

protocol DogView: View {
  
  associatedtype DogType: DogProtocol
  
  var dog: DogType { get }
  
  var treat: Treat { get }
  
  func reward()
  
  static var usesName: Bool { get }
  
  static var usesHappiness: Bool { get }
  
}

extension DogView {
  
  static var usesName: Bool {
    return false
  }
  
  static var usesHappiness: Bool {
    return false
  }
  
}

// MARK: About Using Name or Uappiness

protocol UseName {}

protocol UseHappiness {}

extension DogView where Self: UseName {
  
  static var usesName: Bool {
    return true
  }
  
}

extension DogView where Self: UseHappiness {
  
  static var usesHappiness: Bool {
    return true
  }
  
}

// MARK: DogView Simple Init

/// Simple initialization process that does not involve property wrapper
protocol DogViewSimplInit: DogView {
  
  init(dog: DogType, treat: Treat)
  
}

// MARK: DogView Environment Init

/// Environment initialization process that does not involve property wrapper
protocol DogViewEnvironmentInit: DogView {
  
  init(treat: Treat)
  
}
