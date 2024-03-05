//
//  PlatformDogViewWithObservableInstance.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/27/24.
//

import SwiftUI

struct PlatformDogViewWithObservableInstance: SimpleInitDependencyExplainingView {
  
  var dependencyType: String {
    "@Observable instance var"
  }
  
  typealias Data = DogObject2
  
  func getData() -> Data {
    DogObject2()
  }
  
  struct View1: PlatformDogView, DogViewSimplInit {
    
    var dog: DogObject2
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View2: PlatformDogView, DogViewSimplInit, UseName {
    
    var dog: DogObject2
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View3: PlatformDogView, DogViewSimplInit, UseHappiness {
    
    var dog: DogObject2
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View4: PlatformDogView, DogViewSimplInit, UseName, UseHappiness {
    
    var dog: DogObject2
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }
  
}

#Preview {
  PlatformDogViewWithObservableInstance()
}
