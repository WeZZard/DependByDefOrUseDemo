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

struct CountWrapperView: View {
  
  @Environment(\.dog4)
  var dog
  
  var body: some View {
    CountView()
  }
  
}

struct DogView4: View {
  
  static var dependencyType: String {
    "@Environment"
  }
  
  @State
  var dog: Dog4
  
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
        CountWrapperView()
          .environment(\.dog4, dog)
      }
    }
  }

}

#Preview {
  DogView4(dog: Dog4(), treat: .bone)
}

