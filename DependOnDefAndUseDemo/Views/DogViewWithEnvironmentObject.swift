//
//  DogViewWithEnvironmentObject.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 4/8/24.
//

import SwiftUI

struct DogViewWithEnvironmentObject: View, EnvironmentObjectExplainingView {
  
  var dependencyType: String {
    "@EnvironmentObject"
  }
  
  typealias EnvironmentObjectType = DogObject
  
  func makeEnvironmentObject() -> EnvironmentObjectType {
    DogObject()
  }
  
  struct View1: DSLDogView, DogViewEnvironmentInit {
    
    @EnvironmentObject
    var dog: DogObject
    
    var treat: Treat
    
    init(treat: Treat) {
      self.treat = treat
    }
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View2: DSLDogView, DogViewEnvironmentInit, UseName {
    
    @EnvironmentObject
    var dog: DogObject
    
    var treat: Treat
    
    init(treat: Treat) {
      self.treat = treat
    }
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View3: DSLDogView, DogViewEnvironmentInit, UseHappiness {
    
    @EnvironmentObject
    var dog: DogObject
    
    var treat: Treat
    
    init(treat: Treat) {
      self.treat = treat
    }
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View4: DSLDogView, DogViewEnvironmentInit, UseName, UseHappiness {
    
    @EnvironmentObject
    var dog: DogObject
    
    var treat: Treat
    
    init(treat: Treat) {
      self.treat = treat
    }
    
    func reward() {
      dog.reward(treat)
    }
    
  }

}

#Preview {
  DogViewWithEnvironmentObject()
}
