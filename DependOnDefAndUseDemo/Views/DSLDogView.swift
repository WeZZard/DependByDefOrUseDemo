//
//  DSLDogView.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 3/5/24.
//

import SwiftUI

protocol DSLDogView: DogView {
  
  associatedtype ViewModifierType: ViewModifier = EmptyViewModifier
  
  func makeViewModifier() -> ViewModifierType
  
}

extension DSLDogView {
  
  @ViewBuilder
  private func statusView(_ flag: Bool) -> some View {
    let image = flag ? Image(systemName: "checkmark") : Image(systemName: "xmark")
    image.renderingMode(.template)
      .foregroundStyle(flag ? .green : .red)
  }
  
  var body: some View {
    VStack(spacing: 16) {
      VStack(spacing: 16) {
        dogFaceImage
        VStack(alignment: .leading) {
          HStack {
            Text("Dog name:")
            Spacer()
            Text(Self.usesName ? dog.name : "?")
          }
          HStack {
            Text("Happiness:")
            Spacer()
            Text(Image(systemName: "heart.fill")).foregroundColor(.red) + Text(" ") + Text(verbatim: Self.usesHappiness ? dog.happiness.description : "?")
          }
        }
      }
      VStack {
        HStack {
          Button(action: reward) {
            PawView()
              .font(.largeTitle)
          }
          ViewBodyProduceCounterView()
        }
      }
      VStack(alignment: .leading) {
        Text("Used properties")
        HStack {
          Text("Dog name:")
          Spacer()
          statusView(Self.usesName)
        }
        HStack {
          Text("Happiness:")
          Spacer()
          statusView(Self.usesHappiness)
        }
      }
    }.modifier(makeViewModifier())
  }
  
  func makeViewModifier() -> EmptyViewModifier {
    EmptyViewModifier()
  }
  
}

protocol EnvironmentDSLDogView: DSLDogView where Self.DogType: Equatable, Self.ViewModifierType == EnvironmentValueWritingViewModifier<DogType> {
  
  var newDog: DogType { get }
  
}

extension EnvironmentDSLDogView {
  
  func makeViewModifier() -> EnvironmentValueWritingViewModifier<DogType> {
    EnvironmentValueWritingViewModifier(dog: newDog)
  }
  
}

struct EnvironmentValueWritingViewModifier<DogType: DogProtocol & Equatable>: ViewModifier {
  
  var dog: DogType
  
  func body(content: Content) -> some View {
    content
      .preference(key: DogValueKey<DogType>.self, value: dog)
  }
  
}

struct DogValueKey<DogType: DogProtocol & Equatable>: PreferenceKey {
  
  typealias Value = DogType?
  
  static var defaultValue: Value {
    nil
  }
  
  static func reduce(value: inout Value, nextValue: () -> Value) {
    value = nextValue()
  }
  
}

private let dogFaceImage: some View = Image("dog_face")
  .resizable()
  .aspectRatio(contentMode: .fit)
  .tint(.accentColor)
  .opacity(0.8)
  .frame(width: 100, height: 100)
  .foregroundColor(.accentColor)


