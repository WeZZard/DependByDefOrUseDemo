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
  
  struct View1: DSLDogView, DogViewSimplInit, ViewBodyUseDogAsEnvironment {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View2: DSLDogView, DogViewSimplInit, UseName, ViewBodyUseDogAsEnvironment {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View3: DSLDogView, DogViewSimplInit, UseHappiness, ViewBodyUseDogAsEnvironment {
    
    @State
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View4: DSLDogView, DogViewSimplInit, UseName, UseHappiness, ViewBodyUseDogAsEnvironment {
    
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
