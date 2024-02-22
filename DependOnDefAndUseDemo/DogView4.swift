//
//  DogView4.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/22/24.
//

import SwiftUI
import Observation

struct Dog4 {

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

extension EnvironmentValues {
  
  private struct Key: EnvironmentKey {
    
    typealias Value = Dog4
    
    static var defaultValue: Dog4 {
      Dog4()
    }
    
  }
  
  var dog4: Dog4 {
    get {
      self[Key.self]
    }
    set {
      self[Key.self] = newValue
    }
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

struct CountWrapperView: View {
  
  @Environment(\.dog4)
  var dog
  
  var body: some View {
    CountView()
  }
  
}

struct DogView4: View {
  
  @State
  var dog: Dog4
  
  var treat: Treat

  var body: some View {
    Button {
      dog.reward(treat)
    } label: {
      PawView()
    }
    CountWrapperView()
      .environment(\.dog4, dog)
  }

}

#Preview {
  DogView4(dog: Dog4(), treat: .bone)
}

