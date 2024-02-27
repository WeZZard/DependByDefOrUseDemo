//
//  PlatformDogViewWithObservedObject.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/27/24.
//

import SwiftUI

struct PlatformDogViewWithObservedObject: PlatformDependencyExplainingView {
  
  static var dependencyType: String {
    "@ObservedObject"
  }
  
  @ObservedObject var dog: DogObject
  
  var treat: Treat
  
  func action(_ environmentValues: EnvironmentValues) {
    dog.reward(treat)
  }
  
}

#Preview {
  PlatformDogViewWithObservedObject(dog: DogObject(), treat: .bone)
}
