//
//  FoodRowView.swift
//  What2Cook
//
//  Created by Maizi Liao on 2021-01-16.
//

import SwiftUI
import Combine

final class RemoteImage : ObservableObject {

    enum LoadingState {

        case initial

        case inProgress

        case success(_ image: Image)

        case failure
    }

    @Published var loadingState: LoadingState = .initial

    let url: URL

    init(url: URL) {
        self.url = url
    }

    func load() {
        loadingState = .inProgress

        cancellable = URLSession(configuration: .default)
            .dataTaskPublisher(for: url)
            .map {
                guard let value = UIImage(data: $0.data) else {
                    return .failure
                }

                return .success(Image(uiImage: value))
            }
            .catch { _ in
                Just(.failure)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.loadingState, on: self)
    }

    private var cancellable: AnyCancellable?
}

struct URLImage : View {

    init(url: URL) {
        remoteImage = RemoteImage(url: url)
        remoteImage.load()
    }

    var body: some View {
        ZStack {
            switch remoteImage.loadingState {
                case .initial:
                    EmptyView()
                case .inProgress:
                    Text("Loading")
                case .success(let image):
                    image.resizable()
                case .failure:
                    Text("Failed")
            }
        }
    }

    @ObservedObject private var remoteImage: RemoteImage
}

struct FoodRowView: View {
    var food: Food
    
    var body: some View {
        HStack {
            URLImage(url: URL(string: food.url)!)
                .frame(width: 100, height: 100)
            Spacer()
            Spacer()
            Text(food.name)
            Spacer()
            Spacer()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<food.materials.count) { i in
                        Text(food.materials[i])
                    }
                }
            }
        }
    }
}

struct FoodRowView_Previews: PreviewProvider {
    static var previews: some View {
        FoodRowView(food: Food())
    }
}
