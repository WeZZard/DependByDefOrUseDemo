//
//  DSLDogView.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 3/5/24.
//

import SwiftUI

protocol DSLDogView: DogView {
  
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
          if Self.doesViewBodyUseDogAsEnvironment {
            DogEnvironmentWrapperView {
              ViewBodyProduceCounterView()
            }.environment(DogType.keyPath, dog)
          } else {
            ViewBodyProduceCounterView()
          }
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
    }
  }
  
}

private let dogFaceImage: some View = Image("dog_face")
  .resizable()
  .aspectRatio(contentMode: .fit)
  .tint(.accentColor)
  .opacity(0.8)
  .frame(width: 100, height: 100)
  .foregroundColor(.accentColor)


fileprivate struct DogEnvironmentWrapperView<Content: View>: View {
  
  @Environment(\.dog)
  var dog
  
  let content: Content
  
  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  var body: some View {
    content
  }
  
}
