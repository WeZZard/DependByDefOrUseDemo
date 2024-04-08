//
//  PlatformDogViewWithObservedObject.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/27/24.
//

import SwiftUI

struct PlatformDogViewWithObservedObject: SimpleInitDependencyExplainingView {
  
  var dependencyType: String {
    "@ObservedObject"
  }
  
  typealias Data = DogObject
  
  func makeData() -> Data {
    DogObject()
  }
  
  struct View1: PlatformDogView, DogViewSimplInit {
    
    @ObservedObject
    var dog: DogObject
    
    var treat: Treat
    
    init(dog: DogObject, treat: Treat) {
      self._dog = ObservedObject(wrappedValue: dog)
      self.treat = treat
    }
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View2: PlatformDogView, DogViewSimplInit, UseName {
    
    @ObservedObject
    var dog: DogObject
    
    var treat: Treat
    
    init(dog: DogObject, treat: Treat) {
      self._dog = ObservedObject(wrappedValue: dog)
      self.treat = treat
    }
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View3: PlatformDogView, DogViewSimplInit, UseHappiness {
    
    @ObservedObject
    var dog: DogObject
    
    var treat: Treat
    
    init(dog: DogObject, treat: Treat) {
      self._dog = ObservedObject(wrappedValue: dog)
      self.treat = treat
    }
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View4: PlatformDogView, DogViewSimplInit, UseName, UseHappiness {
    
    @ObservedObject
    var dog: DogObject
    
    var treat: Treat
    
    init(dog: DogObject, treat: Treat) {
      self._dog = ObservedObject(wrappedValue: dog)
      self.treat = treat
    }
    
    func reward() {
      dog.reward(treat)
    }
    
  }
  
}

#Preview {
  PlatformDogViewWithObservedObject()
}
