//
//  PlatformDogViewWithEnvironmentObject.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 4/8/24.
//

import SwiftUI

struct PlatformDogViewWithEnvironmentObject: View, EnvironmentObjectExplainingView {
  
  var dependencyType: String {
    "@EnvironmentObject"
  }
  
  typealias EnvironmentObjectType = DogObject
  
  func makeEnvironmentObject() -> EnvironmentObjectType {
    DogObject()
  }
  
  struct View1: PlatformDogView, DogViewEnvironmentInit {
    
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

  struct View2: PlatformDogView, DogViewEnvironmentInit, UseName {
    
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

  struct View3: PlatformDogView, DogViewEnvironmentInit, UseHappiness {
    
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

  struct View4: PlatformDogView, DogViewEnvironmentInit, UseName, UseHappiness {
    
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
  PlatformDogViewWithEnvironmentObject()
}

