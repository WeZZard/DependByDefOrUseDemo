//
//  DogViewWithObservableInstance.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/22/24.
//

import SwiftUI

struct DogViewWithObservableInstance: SimpleInitDependencyExplainingView {
  
  var dependencyType: String {
    "@Observable instance var"
  }
  
  typealias Data = DogObject2
  
  func makeData() -> Data {
    DogObject2()
  }
  
  struct View1: DSLDogView, DogViewSimplInit {
    
    var dog: DogObject2
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View2: DSLDogView, DogViewSimplInit, UseName {
    
    var dog: DogObject2
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View3: DSLDogView, DogViewSimplInit, UseHappiness {
    
    var dog: DogObject2
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View4: DSLDogView, DogViewSimplInit, UseName, UseHappiness {
    
    var dog: DogObject2
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }
  
}

#Preview {
  DogViewWithObservableInstance()
}

