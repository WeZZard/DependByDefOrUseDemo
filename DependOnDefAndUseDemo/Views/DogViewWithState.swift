//
//  DogViewWithState.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/22/24.
//

import SwiftUI

struct DogViewWithState: View, DependencyExplaining {
  
  static var dependencyType: String {
    "@State"
  }
  
  @State var dog: Dog
  
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
        ViewBodyProduceCounterView()
      }
      Text("Change a dependency but not used.")
    }
  }
  
}

#Preview {
  DogViewWithState(dog: Dog(), treat: .bone)
}
