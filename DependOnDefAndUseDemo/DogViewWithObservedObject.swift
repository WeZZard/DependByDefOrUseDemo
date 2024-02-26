//
//  DogViewWithObservedObject.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/26/24.
//

import SwiftUI
import Combine

struct DogViewWithObservedObject: View {
  
  static var dependencyType: String {
    "@ObservedObject"
  }
  
  @ObservedObject var dog: DogObject
  
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
  DogViewWithObservedObject(dog: DogObject(), treat: .bone)
}

