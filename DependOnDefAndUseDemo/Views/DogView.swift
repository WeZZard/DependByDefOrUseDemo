//
//  DogView.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 3/4/24.
//

import SwiftUI

protocol DogView: View {
  
  associatedtype DogType: DogProtocol
  
  var dog: DogType { get }
  
  var treat: Treat { get }
  
  func reward()
  
  static var usesName: Bool { get }
  
  static var usesHappiness: Bool { get }
  
  static var doesViewBodyUseDogAsEnvironment: Bool { get }
  
}

extension DogView {
  
  static var usesName: Bool {
    return false
  }
  
  static var usesHappiness: Bool {
    return false
  }
  
  static var doesViewBodyUseDogAsEnvironment: Bool {
    return false
  }
  
}

extension DogView {
  
  private func statusView(_ flag: Bool) -> Image {
    flag ? Image(systemName: "checkmark") : Image(systemName: "xmark")
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

// MARK: About Using Name or Uappiness

protocol UseName {}

protocol UseHappiness {}

protocol ViewBodyUseDogAsEnvironment {}

extension DogView where Self: UseName {
  
  static var usesName: Bool {
    return true
  }
  
}

extension DogView where Self: UseHappiness {
  
  static var usesHappiness: Bool {
    return true
  }
  
}

extension DogView where Self: ViewBodyUseDogAsEnvironment {
  
  static var doesViewBodyUseDogAsEnvironment: Bool {
    return true
  }
  
}

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

// MARK: DogView Simple Init

/// Simple initialization process that does not involve property wrapper
protocol DogViewSimplInit: DogView {
  
  init(dog: DogType, treat: Treat)
  
}

protocol SimpleInitDependencyExplainingView: DependencyExplainingView where
  View1: DogView,
  View2: DogView,
  View3: DogView,
  View4: DogView,
  View1.DogType == Data,
  View2.DogType == Data,
  View3.DogType == Data,
  View4.DogType == Data
{
  
  associatedtype Data: DogProtocol
  
  func getData() -> Data
  
}

extension SimpleInitDependencyExplainingView where Self.View1: DogViewSimplInit {
  
  func makeView1() -> View1 {
    View1(dog: getData(), treat: .bone)
  }
  
}

extension SimpleInitDependencyExplainingView where Self.View2: DogViewSimplInit {
  
  func makeView2() -> View2 {
    View2(dog: getData(), treat: .bone)
  }
  
}

extension SimpleInitDependencyExplainingView where Self.View3: DogViewSimplInit {
  
  func makeView3() -> View3 {
    View3(dog: getData(), treat: .bone)
  }
  
}

extension SimpleInitDependencyExplainingView where Self.View4: DogViewSimplInit {
  
  func makeView4() -> View4 {
    View4(dog: getData(), treat: .bone)
  }
  
}

