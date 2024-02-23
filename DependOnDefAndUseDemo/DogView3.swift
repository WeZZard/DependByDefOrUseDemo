//
//  DogView3.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/22/24.
//

import SwiftUI
import Observation

@Observable
class DogObject2 {

  var happyValue: Int = 0

  func reward(_ treat: Treat) {
    switch treat {
      case .bone:
        happyValue += 3
      case .frisbee:
        happyValue += 1
    }
  }

}

struct DogView3: View {
  
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
        CountView()
      }
    }
  }

}

#Preview {
  DogView3(dog: DogObject2(), treat: .bone)
}

