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
      Text("Change a dependency but not used.")
      Text("Dependency: \(Self.dependencyType)")
      VStack {
        Button {
          dog.reward(treat)
        } label: {
          PawView()
        }
        EnvironmentWrappedView()
          .environment(\.dog4, dog)
      }
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
