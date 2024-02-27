//
//  PlatformDogViewWithStateObject.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/27/24.
//

import SwiftUI

struct PlatformDogViewWithStateObject: PlatformDependencyExplainingView {
  
  static var dependencyType: String {
    "@StateObject"
  }
  
  @StateObject var dog: DogObject
  
  var treat: Treat
  
  func action() {
    dog.reward(treat)
  }
  
}

#Preview {
  PlatformDogViewWithStateObject(dog: DogObject(), treat: .bone)
}
