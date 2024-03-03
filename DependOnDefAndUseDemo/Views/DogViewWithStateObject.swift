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
  
  func getData() -> Data {
    DogObject()
  }
  
  struct View1: DogViewSimplInit {
    
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

  struct View2: DogViewSimplInit, UseName {
    
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

  struct View3: DogViewSimplInit, UseHappiness {
    
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

  struct View4: DogViewSimplInit, UseName, UseHappiness {
    
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

