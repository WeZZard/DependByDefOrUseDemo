//
//  PlatformDogViewWithStateObject.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/27/24.
//

import SwiftUI

struct PlatformDogViewWithStateObject: SimpleInitDependencyExplainingView {
  
  var dependencyType: String {
    "@StateObject"
  }
  
  typealias Data = DogObject
  
  func getData() -> Data {
    DogObject()
  }
  
  struct View1: PlatformDogView, DogViewSimplInit {
    
    @StateObject
    var dog: DogObject
    
    var treat: Treat
    
    init(dog: DogObject, treat: Treat) {
      self._dog = StateObject(wrappedValue: dog)
      self.treat = treat
    }
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View2: PlatformDogView, DogViewSimplInit, UseName {
    
    @StateObject
    var dog: DogObject
    
    var treat: Treat
    
    init(dog: DogObject, treat: Treat) {
      self._dog = StateObject(wrappedValue: dog)
      self.treat = treat
    }
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View3: PlatformDogView, DogViewSimplInit, UseHappiness {
    
    @StateObject
    var dog: DogObject
    
    var treat: Treat
    
    init(dog: DogObject, treat: Treat) {
      self._dog = StateObject(wrappedValue: dog)
      self.treat = treat
    }
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct View4: PlatformDogView, DogViewSimplInit, UseName, UseHappiness {
    
    @StateObject
    var dog: DogObject
    
    var treat: Treat
    
    init(dog: DogObject, treat: Treat) {
      self._dog = StateObject(wrappedValue: dog)
      self.treat = treat
    }
    
    func reward() {
      dog.reward(treat)
    }
    
  }

}

#Preview {
  PlatformDogViewWithStateObject()
}
