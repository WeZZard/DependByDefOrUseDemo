//
//  DogViewWithStateObject.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/22/24.
//

import SwiftUI
import Combine

struct DogViewWithStateObject: SimpleInitDependencyExplainingView {
  
  var dependencyType: String {
    "@StateObject"
  }
  
  typealias Data = DogObject
  
  func makeData() -> Data {
    DogObject()
  }
  
  struct View1: DSLDogView, DogViewSimplInit {
    
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

  struct View2: DSLDogView, DogViewSimplInit, UseName {
    
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

  struct View3: DSLDogView, DogViewSimplInit, UseHappiness {
    
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

  struct View4: DSLDogView, DogViewSimplInit, UseName, UseHappiness {
    
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
  DogViewWithStateObject()
}

