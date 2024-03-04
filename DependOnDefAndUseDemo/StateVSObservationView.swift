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
    VStack {
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
  
  var animalOnTheStageBinding: Binding<Animal> { get }

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
      Picker("Animal on the stage", selection: animalOnTheStageBinding) {
        Text("Dog").tag(Animal.dog)
        Text("Cat").tag(Animal.cat)
      }.pickerStyle(.segmented)
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
  var summaryView: some View {
    HStack {
      Image(animalOnTheStage.name + "_face")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 28, height: 28)
      Text(" ") + Text(Image(systemName: "pawprint.fill")) + Text(verbatim: " x ") + Text(verbatim: pawprints.description)
    }.monospacedDigit()
  }
  
}

struct StateAnimalView: AnimalView {
  
  static var bodyAccessCount: Int = 0

  @State
  var animalOnTheStage: Animal = .dog
  
  var animalOnTheStageBinding: Binding<Animal> {
    $animalOnTheStage
  }
  
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
  
  var animalOnTheStageBinding: Binding<Animal> {
    Bindable(model).animalOnTheStage
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
