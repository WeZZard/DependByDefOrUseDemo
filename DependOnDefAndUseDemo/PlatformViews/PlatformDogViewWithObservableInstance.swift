//
//  PlatformDogViewWithObservableInstance.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/27/24.
//

import SwiftUI

struct PlatformDogViewWithObservableInstance: PlatformDependencyExplainingView {
  
  var dependencyType: String {
    "@Observable instance var"
  }
  
  var dog: DogObject2
  
  var treat: Treat
  
  func action(_ environmentValues: EnvironmentValues) {
    dog.reward(treat)
  }
  
}

#Preview {
  PlatformDogViewWithObservableInstance(dog: DogObject2(), treat: .bone)
}
