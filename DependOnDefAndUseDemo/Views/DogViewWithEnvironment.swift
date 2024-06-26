//
//  DogViewWithEnvironment.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/22/24.
//

import SwiftUI

struct DogViewWithEnvironment: View, EnvironmentExplainingView {
  
  var dependencyType: String {
    "@Environment"
  }
  
  typealias EnvironmentValueType = Dog
  
  @State
  private var dog: Dog = Dog()
  
  struct View1: EnvironmentDSLDogView, DogViewEnvironmentInit {
    
    @Environment(Dog.keyPath)
    var dog: Dog
    
    @State
    var newDog: Dog
    
    var treat: Treat
    
    init(treat: Treat) {
      self.treat = treat
      self.newDog = Dog()
    }
    
    func reward() {
      newDog.reward(treat)
    }
    
  }

  struct View2: EnvironmentDSLDogView, DogViewEnvironmentInit, UseName {
    
    @Environment(Dog.keyPath)
    var dog: Dog
    
    @State
    var newDog: Dog
    
    var treat: Treat
    
    init(treat: Treat) {
      self.treat = treat
      self.newDog = Dog()
    }
    
    func reward() {
      newDog.reward(treat)
    }
    
  }

  struct View3: EnvironmentDSLDogView, DogViewEnvironmentInit, UseHappiness {
    
    @Environment(Dog.keyPath)
    var dog: Dog
    
    @State
    var newDog: Dog
    
    var treat: Treat
    
    init(treat: Treat) {
      self.treat = treat
      self.newDog = Dog()
    }
    
    func reward() {
      newDog.reward(treat)
    }
    
  }

  struct View4: EnvironmentDSLDogView, DogViewEnvironmentInit, UseName, UseHappiness {
    
    @Environment(Dog.keyPath)
    var dog: Dog
    
    @State
    var newDog: Dog
    
    var treat: Treat
    
    init(treat: Treat) {
      self.treat = treat
      self.newDog = Dog()
    }
    
    func reward() {
      newDog.reward(treat)
    }
    
  }

}

#Preview {
  DogViewWithEnvironment()
}
