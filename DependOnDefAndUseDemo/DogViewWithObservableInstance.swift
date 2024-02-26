//
//  DogViewWithObservableInstance.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/22/24.
//

import SwiftUI

struct DogViewWithObservableInstance: View, DependencyExplaining {
  
  static var dependencyType: String {
    "@Observable class instance"
  }
  
  var dog: DogObject2
  
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
        ViewBodyProduceCounterView()
      }
    }
  }

}

#Preview {
  DogViewWithObservableInstance(dog: DogObject2(), treat: .bone)
}

