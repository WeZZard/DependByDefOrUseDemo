//
//  PlatformDogViewWithEnvironment.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/27/24.
//

import SwiftUI

struct PlatformDogViewWithEnvironment: View, DependencyExplaining {
  
  var dependencyType: String {
    "@Environment"
  }
  
  @State
  var dog: Dog
  
  var treat: Treat
  
  func action() {
    dog.reward(treat)
  }
  
  var body: some View {
    PlatformDogViewWithEnvironmentBody(treat: treat, action: action)
      .environment(\.dog, dog)
  }
}

private struct PlatformDogViewWithEnvironmentBody: PlatformDependencyExplainingView {
  
  var dependencyType: String {
    "@Environment"
  }
  
  @Environment(\.dog)
  var dog: Dog
  
  var treat: Treat
  
  let action: () -> Void
  
  func action(_ environmentValues: EnvironmentValues) {
    action()
  }
  
}

#Preview {
  PlatformDogViewWithEnvironment(dog: Dog(), treat: .bone)
}
