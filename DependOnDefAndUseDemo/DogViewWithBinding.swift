//
//  DogViewWithBinding.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/26/24.
//

import SwiftUI

struct DogViewWithBinding: View, DependencyExplaining {
  
  static var dependencyType: String {
    "@Binding"
  }
  
  @Binding
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
        ViewBodyProduceCounterView()
      }
    }
  }

}

#Preview {
  DogViewWithBinding(dog: .constant(Dog()), treat: .bone)
}
