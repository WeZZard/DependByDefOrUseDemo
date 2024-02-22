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

  var dog: DogObject2
  
  var treat: Treat

  var body: some View {
    Button {
      dog.reward(treat)
    } label: {
      PawView()
    }
    CountView()
  }

}

private struct CountView: View {
  
  private static var counter: Int = 0
  
  let counter: Int
  
  init() {
    Self.counter += 1
    self.counter = Self.counter
  }
  
  var body: some View {
    Text(" x ") + Text(verbatim: counter.description)
  }
  
}

#Preview {
  DogView3(dog: DogObject2(), treat: .bone)
}

