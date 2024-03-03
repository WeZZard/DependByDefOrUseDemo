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
  
  func getData() -> Data {
    Dog()
  }
  
  struct View1: DogViewSimplInit {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View2: DogViewSimplInit, UseName {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View3: DogViewSimplInit, UseHappiness {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View4: DogViewSimplInit, UseName, UseHappiness {
    
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
