//
//  DogViewWithEnvironment.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/22/24.
//

import SwiftUI

struct DogViewWithEnvironment: View, DependencyExplaining {
  
  static var dependencyType: String {
    "@Environment"
  }
  
  @State
  var dog: Dog
  
  var treat: Treat

  var body: some View {
    VStack(spacing: 8) {
      Text("View Dependency: \(Self.dependencyType)")
      VStack {
        Button {
          dog.reward(treat)
        } label: {
          PawView()
        }
        EnvironmentWrappedView()
          .environment(\.dog4, dog)
      }
      Text("Change a dependency but not used.")
    }
  }

}

#Preview {
  DogViewWithEnvironment(dog: Dog(), treat: .bone)
}

private struct EnvironmentWrappedView: View {
  
  @Environment(\.dog4)
  var dog
  
  var body: some View {
    ViewBodyProduceCounterView()
  }
  
}
