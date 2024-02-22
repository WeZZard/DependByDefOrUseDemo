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

  @StateObject var dog: DogObject
  
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
  DogView2(dog: DogObject(), treat: .bone)
}

