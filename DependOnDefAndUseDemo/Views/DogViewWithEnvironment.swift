//
//  DogViewWithEnvironment.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/22/24.
//

import SwiftUI

struct DogViewWithEnvironment: View, SimpleInitDependencyExplainingView {
  
  var dependencyType: String {
    "@Environment"
  }
  
  typealias Data = Dog
  
  func getData() -> Dog {
    Dog()
  }
  
  struct View1: DogViewSimplInit, ViewBodyUseDogAsEnvironment {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View2: DogViewSimplInit, UseName, ViewBodyUseDogAsEnvironment {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View3: DogViewSimplInit, UseHappiness, ViewBodyUseDogAsEnvironment {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View4: DogViewSimplInit, UseName, UseHappiness, ViewBodyUseDogAsEnvironment {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

}

#Preview {
  DogViewWithEnvironment()
}
