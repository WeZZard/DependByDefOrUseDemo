//
//  DogViewWithObservedObject.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/26/24.
//

import SwiftUI
import Combine

struct DogViewWithObservedObject: SimpleInitDependencyExplainingView {
  
  var dependencyType: String {
    "@ObservedObject"
  }
  
  typealias Data = DogObject
  
  func getData() -> Data {
    DogObject()
  }
  
  struct View1: DSLDogView, DogViewSimplInit {
    
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

  struct View2: DSLDogView, DogViewSimplInit, UseName {
    
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

  struct View3: DSLDogView, DogViewSimplInit, UseHappiness {
    
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

  struct View4: DSLDogView, DogViewSimplInit, UseName, UseHappiness {
    
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
  DogViewWithObservedObject()
}

