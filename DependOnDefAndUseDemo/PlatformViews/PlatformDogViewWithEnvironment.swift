//
//  PlatformDogViewWithEnvironment.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 4/8/24.
//

import SwiftUI

struct PlatformDogViewWithEnvironment: View, EnvironmentExplainingView {
  
  var dependencyType: String {
    "@Environment"
  }
  
  typealias EnvironmentValueType = Dog
  
  @State
  private var dog: Dog = Dog()
  
  struct View1: EnvironmentPlatformDogView, DogViewEnvironmentInit {
    
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

  struct View2: EnvironmentPlatformDogView, DogViewEnvironmentInit, UseName {
    
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

  struct View3: EnvironmentPlatformDogView, DogViewEnvironmentInit, UseHappiness {
    
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

  struct View4: EnvironmentPlatformDogView, DogViewEnvironmentInit, UseName, UseHappiness {
    
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
  PlatformDogViewWithEnvironment()
}
