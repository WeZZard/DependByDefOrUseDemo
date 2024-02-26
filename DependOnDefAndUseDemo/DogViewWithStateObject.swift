//
//  DogViewWithStateObject.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/22/24.
//

import SwiftUI
import Combine

struct DogViewWithStateObject: View, DependencyExplaining {
  
  static var dependencyType: String {
    "@StateObject"
  }
  
  @StateObject var dog: DogObject
  
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
  DogViewWithStateObject(dog: DogObject(), treat: .bone)
}

