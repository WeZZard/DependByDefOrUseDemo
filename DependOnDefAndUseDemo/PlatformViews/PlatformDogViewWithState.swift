//
//  PlatformDogViewWithState.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/27/24.
//

import SwiftUI

struct PlatformDogViewWithState: SimpleInitDependencyExplainingView {
  
  var dependencyType: String {
    "@State"
  }
  
  typealias Data = Dog
  
  func getData() -> Data {
    Dog()
  }
  
  struct View1: PlatformDogView, DogViewSimplInit {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View2: PlatformDogView, DogViewSimplInit, UseName {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View3: PlatformDogView, DogViewSimplInit, UseHappiness {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View4: PlatformDogView, DogViewSimplInit, UseName, UseHappiness {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }
}

#Preview {
  PlatformDogViewWithState()
}
