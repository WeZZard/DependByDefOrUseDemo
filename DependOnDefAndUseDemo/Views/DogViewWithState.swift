//
//  DogViewWithState.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/22/24.
//

import SwiftUI

struct DogViewWithState: SimpleInitDependencyExplainingView {
  
  var dependencyType: String {
    "@State"
  }
  
  typealias Data = Dog
  
  func makeData() -> Data {
    Dog()
  }
  
  struct View1: DSLDogView, DogViewSimplInit {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View2: DSLDogView, DogViewSimplInit, UseName {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View3: DSLDogView, DogViewSimplInit, UseHappiness {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View4: DSLDogView, DogViewSimplInit, UseName, UseHappiness {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

}

#Preview {
  DogViewWithState()
}
