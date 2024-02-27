//
//  PlatformDogViewWithState.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/27/24.
//

import SwiftUI

struct PlatformDogViewWithState: PlatformDependencyExplainingView {
  
  static var dependencyType: String {
    "@State"
  }
  
  @State var dog: Dog
  
  var treat: Treat
  
  func action(_ environmentValues: EnvironmentValues) {
    dog.reward(treat)
  }
  
}

#Preview {
  PlatformDogViewWithState(dog: Dog(), treat: .bone)
}
