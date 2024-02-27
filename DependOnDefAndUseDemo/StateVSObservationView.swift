//
//  StateVSObservationView.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/12/24.
//

import SwiftUI
import Observation

@Observable
private class Model {
  
  var animalOnTheStage: Animal = .dog
  
  var dogPawprints = 0
  
  var catPawprints = 1
  
}

struct StateVSObservationView: View {
  
  var body: some View {
    HStack {
      VStack {
        Text("@State")
        StateAnimalView()
      }
      VStack {
        Text("Observation")
        ObservationAnimalView()
      }
    }
  }
  
}

#Preview {
  StateVSObservationView()
}

protocol AnimalView: View {
  
  static var bodyAccessCount: Int { get set }

  var animalOnTheStage: Animal { get nonmutating set }
  
  var dogPawprints: Int { get nonmutating set }
  
  var catPawprints: Int { get nonmutating set }
  
}

extension AnimalView {
  
  var pawprints: Int {
    switch animalOnTheStage {
    case .dog:
      return dogPawprints
    case .cat:
      return catPawprints
    }
  }
  
  @ViewBuilder
  var body: some View {
    let _ = (Self.bodyAccessCount += 1)
    Text("Body access count: ") + Text(verbatim: Self.bodyAccessCount.description)
    VStack(spacing: 16) {
      HStack {
        Spacer()
        animalButtons(.dog)
        Spacer()
        animalButtons(.cat)
        Spacer()
      }
        .font(.title)
      summaryView
        .font(.title2)
    }
    .padding()
    .border(.secondary, width: 0.5)
  }
  
  @ViewBuilder
  func animalButtons(_ animal: Animal) -> some View {
    VStack(spacing: 8) {
      Button {
        animalOnTheStage = animal
      } label: {
        Image(systemName: "\(animal.name).fill")
      }
      HStack {
        Button {
          switch animal {
          case .dog:
            dogPawprints += 1
          case .cat:
            catPawprints += 1
          }
        } label: {
          Image(systemName: "pawprint.fill")
        }
      }
    }.opacity(animalOnTheStage == animal ? 1.0 : 0.5)
  }
  
  @ViewBuilder
  var summaryView: Text {
    Text(Image(systemName: animalOnTheStage.name + ".fill")) + Text(" ") + Text(Image(systemName: "pawprint.fill")) + Text(verbatim: " x ") + Text(verbatim: pawprints.description)
  }
  
}

struct StateAnimalView: AnimalView {
  
  static var bodyAccessCount: Int = 0

  @State
  var animalOnTheStage: Animal = .dog
  
  @State
  var dogPawprints = 0
  
  @State
  var catPawprints = 1
  
}

struct ObservationAnimalView: AnimalView {
  
  static var bodyAccessCount: Int = 0
  
  private var model = Model()
  
  var animalOnTheStage: Animal {
    get {
      model.animalOnTheStage
    }
    nonmutating set {
      model.animalOnTheStage = newValue
    }
  }
  
  var dogPawprints: Int {
    get {
      model.dogPawprints
    }
    nonmutating set {
      model.dogPawprints = newValue
    }
  }
  
  var catPawprints: Int {
    get {
      model.catPawprints
    }
    nonmutating set {
      model.catPawprints = newValue
    }
  }
  
}
