//
//  UIViewRepresentableAndEnvironment.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/13/24.
//

import SwiftUI

private let dogFace: some View = Image("dog_face")
  .resizable()
  .aspectRatio(contentMode: .fill)
  .frame(width: 22, height: 22)

private let catFace: some View = Image("cat_face")
  .resizable()
  .aspectRatio(contentMode: .fill)
  .frame(width: 22, height: 22)

struct UIViewRepresentableAndEnvironment: View {
  
  @State
  var animalOnTheStage: Animal = .dog
  
  @State
  var dogPawprints: Int = 0
  
  @State
  var catPawprints: Int = 0
  
  var body: some View {
    VStack {
      VStack {
        HStack {
          Text("var")
          dogFace
          catFace
          Text(" ")
          Text("EnvironmentValues ") + Text(Image(systemName: "pawprint.fill"))
        }
        VarAnimalAndEnvironmentValuesPawprints(animal: animalOnTheStage)
          .environment(\.dogPawprints, dogPawprints)
          .environment(\.catPawprints, catPawprints)
          .border(.secondary, width: 0.5)
      }
      VStack {
        Text("All EnvironmentValues")
        AllEnvironmentValues()
          .environment(\.dogPawprints, dogPawprints)
          .environment(\.catPawprints, catPawprints)
          .environment(\.animalOnTheStage, animalOnTheStage)
          .border(.secondary, width: 0.5)
      }
      VStack {
        HStack {
          Text("var")
          dogFace
          catFace
          Text(" ")
          Text("@Environment ") + Text(Image(systemName: "pawprint.fill"))
        }
        VarAnimalAndEnvironmentPawprints(animal: animalOnTheStage)
          .environment(\.dogPawprints, dogPawprints)
          .environment(\.catPawprints, catPawprints)
          .border(.secondary, width: 0.5)
      }
      VStack {
        Text("All @Environment")
        AllEnvironment()
          .environment(\.dogPawprints, dogPawprints)
          .environment(\.catPawprints, catPawprints)
          .environment(\.animalOnTheStage, animalOnTheStage)
          .border(.secondary, width: 0.5)
      }
      Picker("Animal on the stage", selection: $animalOnTheStage) {
        Text("Dog").tag(Animal.dog)
        Text("Cat").tag(Animal.cat)
      }
      .pickerStyle(.segmented)
      Spacer()
      HStack {
        Spacer()
        pawprintButton(.dog)
        Spacer()
        pawprintButton(.cat)
        Spacer()
      }
    }.padding()
  }
  
  @ViewBuilder
  func pawprintButton(_ animal: Animal) -> some View {
    Button {
      switch animal {
      case .dog:
        dogPawprints += 1
      case .cat:
        catPawprints += 1
      }
    } label: {
      Image(systemName: "pawprint.fill")
    }.font(.title)
  }
  
}

private struct CounterView: View {
  
  var animalOnTheStage: Animal
  
  var pawprints: Int
  
  var updateUIViewAccessCount: Int
  
  var counterText: String {
    pawprints.description
  }
  
  var body: some View {
    VStack {
      summaryView
        .font(.title)
      Spacer()
      VStack(alignment: .trailing) {
        HStack {
          Spacer()
          Text("updateUIView access count: ")
          Text(verbatim: updateUIViewAccessCount.description)
            .monospacedDigit()
        }.font(.footnote)
      }
    }
    .padding()
  }
  
  @ViewBuilder
  var summaryView: some View {
    HStack {
      Image(animalOnTheStage.name + "_face")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 56, height: 56)
      Spacer()
      Text(Image(systemName: "pawprint.fill")) + Text(verbatim: " x ") + Text(verbatim: pawprints.description).monospacedDigit()
    }.padding()
  }
  
}

extension _UIHostingView where Content == CounterView {
  
  fileprivate convenience init(activeCounter: Animal, counter: Int, updateCount: Int) {
    self.init(rootView: CounterView(animalOnTheStage: activeCounter, pawprints: counter, updateUIViewAccessCount: updateCount))
  }
  
}

private class PlatformCoordinator {
  
  var updateCount: Int = 0
  
}

private protocol PlatformAnimalView: UIViewRepresentable where Self.Coordinator == PlatformCoordinator {
  
  func animalOnTheStage(for context: Context) -> Animal
  
  func pawprints(for context: Context) -> Int
  
}

extension PlatformAnimalView {
  
  func makeUIView(context: Context) -> _UIHostingView<CounterView> {
    _UIHostingView<CounterView>(activeCounter: .dog, counter: 0, updateCount: 0)
  }
  
  func updateUIView(_ uiView: _UIHostingView<CounterView>, context: Context) {
    context.coordinator.updateCount += 1
    uiView.rootView.animalOnTheStage = animalOnTheStage(for: context)
    uiView.rootView.pawprints = pawprints(for: context)
    uiView.rootView.updateUIViewAccessCount = context.coordinator.updateCount
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator()
  }
  
}

private struct VarAnimalAndEnvironmentValuesPawprints: PlatformAnimalView {
  
  var animal: Animal
  
  func pawprints(for context: Context) -> Int {
    switch animal {
    case .dog:
      context.environment.dogPawprints
    case .cat:
      context.environment.catPawprints
    }
  }
  
  func animalOnTheStage(for context: Context) -> Animal {
    animal
  }
}

private struct AllEnvironmentValues: PlatformAnimalView {
  
  func pawprints(for context: Context) -> Int {
    switch context.environment.animalOnTheStage {
    case .dog:
      context.environment.dogPawprints
    case .cat:
      context.environment.catPawprints
    }
  }
  
  func animalOnTheStage(for context: Context) -> Animal {
    context.environment.animalOnTheStage
  }
  
}

private struct VarAnimalAndEnvironmentPawprints: PlatformAnimalView {
  
  @Environment(\.dogPawprints)
  var dogPawprints
  
  @Environment(\.catPawprints)
  var catPawprints
  
  var animal: Animal
  
  func pawprints(for context: Context) -> Int {
    switch animal {
    case .dog:
      dogPawprints
    case .cat:
      catPawprints
    }
  }
  
  func animalOnTheStage(for context: Context) -> Animal {
    animal
  }
  
}

private struct AllEnvironment: PlatformAnimalView {
  
  @Environment(\.dogPawprints)
  var dogPawprints
  
  @Environment(\.catPawprints)
  var catPawprints
  
  @Environment(\.animalOnTheStage)
  var animal
  
  func pawprints(for context: Context) -> Int {
    switch animal {
    case .dog:
      dogPawprints
    case .cat:
      catPawprints
    }
  }
  
  func animalOnTheStage(for context: Context) -> Animal {
    animal
  }
  
}

#Preview {
  UIViewRepresentableAndEnvironment()
}
