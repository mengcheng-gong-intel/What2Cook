//
//  MaterialImageRowView.swift
//  What2Cook
//
//  Created by Maizi Liao on 2021-01-16.
//

import SwiftUI
import Combine

final class RemoteMaterials : ObservableObject {
    
    enum LoadingState {
        
        case initial
        
        case inProgress
        
        case success(_ materials: [String])
        
        case failure
    }
    
    @Published var loadingState: LoadingState = .initial
    
    let materialImage: MaterialImage
    
    init(materialImage: MaterialImage) {
        self.materialImage = materialImage
    }
    
    func getURLRequest() -> URLRequest {
        let parameterDictionary = ["image" : self.materialImage.image.jpegData(compressionQuality: 0.01)?.base64EncodedString()]
        var request = URLRequest(url: URL(string: "https://us-central1-what2cook-301906.cloudfunctions.net/Predict")!)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: [])
        request.httpBody = httpBody
        return request
    }
    
    func load() {
        loadingState = .inProgress
        
        cancellable = URLSession(configuration: .default)
            .dataTaskPublisher(for: getURLRequest())
            .map {
                guard let results = try? JSONDecoder().decode([String].self, from: $0.data) else {
                    return .failure
                }
                
                materials = materials + results
                
                return .success(results)
            }
            .catch { _ in
                Just(.failure)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.loadingState, on: self)
    }
    
    private var cancellable: AnyCancellable?
}

struct ImageMaterials : View {
    
    init(materialImage: MaterialImage) {
        remoteMaterials = RemoteMaterials(materialImage: materialImage)
        remoteMaterials.load()
    }
    
    var body: some View {
        ZStack {
            switch remoteMaterials.loadingState {
            case .initial:
                EmptyView()
            case .inProgress:
                Text("Recognizing")
            case .success(let materials):
                HStack {
                    ForEach(0..<materials.count) { i in
                        Text(materials[i])
                    }
                }
            case .failure:
                Text("Failed")
            }
        }
    }
    
    @ObservedObject private var remoteMaterials: RemoteMaterials
}

struct MaterialImageRowView: View {
    var materialImage: MaterialImage
    
    var body: some View {
        HStack {
            Image(uiImage: materialImage.image)
                .resizable()
                .frame(width: 100, height: 100)
            Spacer()
            Spacer()
            ScrollView(.horizontal, showsIndicators: false) {
                ImageMaterials(materialImage: materialImage)
            }
        }
    }
}

struct MaterialImageRowView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialImageRowView(
            materialImage: MaterialImage()
        )
    }
}
