//
//  DogView2.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/22/24.
//

import SwiftUI
import Combine

class DogObject: ObservableObject {

  @Published
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

struct DogView2: View {
  
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
        CountView()
      }
    }
  }

}

#Preview {
  DogView2(dog: DogObject(), treat: .bone)
}

