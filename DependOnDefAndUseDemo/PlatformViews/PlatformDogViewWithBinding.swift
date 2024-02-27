//
//  PlatformDogViewWithBinding.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/27/24.
//

import SwiftUI

struct PlatformDogViewWithBinding: PlatformDependencyExplainingView {
  
  static var dependencyType: String {
    "@Binding"
  }
  
  @Binding
  var dog: Dog
  
  var treat: Treat

  func action() {
    dog.reward(treat)
  }
  
}

#Preview {
  PlatformDogViewWithBinding(dog: .constant(Dog()), treat: .bone)
}
