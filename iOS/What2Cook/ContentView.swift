//
//  ContentView.swift
//  What2Cook
//
//  Created by Maizi Liao on 2021-01-16.
//

import SwiftUI

struct ContentView: View {
    @State private var materialImages: [MaterialImage] = [MaterialImage]()
    @State private var foodResults: [Food] = [Food]()
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentImagePickerActionScheet = false
    @State private var shouldPresentCamera = false
    @State private var shouldPresentFoodResult = false
    
    var body: some View {
        NavigationView {
            List(materialImages) { materialImage in
                MaterialImageRowView(materialImage: materialImage)
            }
            .navigationTitle("What I have...")
        }
        
        HStack {
            Button("Add") {
                self.shouldPresentImagePickerActionScheet = true
            }
            .padding()
            .sheet(isPresented: $shouldPresentImagePicker) {
                ImagePickerView(
                    sourceType: self.shouldPresentCamera ? .camera : .photoLibrary,
                    materialImages: self.$materialImages,
                    isPresented: self.$shouldPresentImagePicker
                )
            }
            .actionSheet(isPresented: $shouldPresentImagePickerActionScheet) { () -> ActionSheet in
                ActionSheet(
                    title: Text("Choose source"),
                    message: Text("Please choose your preferred source of images"),
                    buttons: [
                        ActionSheet.Button.default(
                            Text("Camera"),
                            action: {
                                self.shouldPresentImagePicker = true
                                self.shouldPresentCamera = true
                            }
                        ),
                        ActionSheet.Button.default(
                            Text("Photo Library"),
                            action: {
                                self.shouldPresentImagePicker = true
                                self.shouldPresentCamera = false
                            }
                        ),
                        ActionSheet.Button.cancel()
                    ]
                )
            }
            
            Button("What2Cook!") {
                let lock = NSLock()
                let Url = String(format: "https://us-central1-what2cook-301906.cloudfunctions.net/Query")
                guard let serviceUrl = URL(string: Url) else { return }
                let parameterDictionary = ["materials" : materials]
                var request = URLRequest(url: serviceUrl)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                    return
                }
                request.httpBody = httpBody
                let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                    guard let data = data else { return }
                    if let jsonString = String(data: data, encoding: .utf8) {
                        let jsonData = Data(jsonString.utf8)
                        let decoder = JSONDecoder()
                        let foods = try! decoder.decode([Food].self, from: jsonData)
                        foodResults = foods
                        lock.unlock()
                    }
                }
                task.resume()
                lock.lock()
                shouldPresentFoodResult = true
            }
            .padding()
            .sheet(isPresented: $shouldPresentFoodResult, content: {
                FoodResultView(foodResults: self.foodResults)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
