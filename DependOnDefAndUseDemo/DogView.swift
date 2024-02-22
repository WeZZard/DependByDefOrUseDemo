//
//  DogView.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/22/24.
//

import SwiftUI

enum Treat {
  case bone
  case frisbee
}

struct Dog: Equatable {

  var happyValue: Int = 0

  mutating func reward(_ treat: Treat) {
    switch treat {
      case .bone:
        happyValue += 3
      case .frisbee:
        happyValue += 1
    }
  }

}

struct DogView: View {
  
  @State var dog: Dog
  @State var count: Int = 0
  
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

struct PawView: View {
  
  var body: some View {
    Image(systemName: "pawprint.fill")
  }
  
}

#Preview {
  DogView(dog: Dog(), treat: .bone)
}
