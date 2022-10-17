//
//  ContentView.swift
//  Instafilter
//
//  Created by Erik Radicheski da Silva on 17/10/22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var filterIntensity: Float = 0.5
    
    @State private var showingImagePicker = false
    
    @State private var currentFilter: CIFilter = .sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in applyProcessing() }
                }
                .padding(.vertical)
                
                HStack {
                    Button("Chage Filter") {
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage, perform: loadImage)
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Button("Crystallize") { setCurrentFilter(.crystallize()) }
                Button("Edges") { setCurrentFilter(.edges()) }
                Button("Gaussian Blur") { setCurrentFilter(.gaussianBlur()) }
                Button("Pixellate") { setCurrentFilter(.pixellate()) }
                Button("Unsharp Mask") { setCurrentFilter(.unsharpMask()) }
                Button("Vignette") { setCurrentFilter(.vignette()) }
                Button("Sepia tone") { setCurrentFilter(.sepiaTone()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    private func loadImage(_ inputImage: UIImage?) {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    private func save() {
        guard let processedImage = processedImage else { return }
        
        ImageSave(processedImage)
            .writeToPhotoAlbum {
                print("Success!")
            } errorHandler: {
                print("Oops! \($0.localizedDescription)")
            }
    }
    
    private func setCurrentFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage(inputImage)
    }
    
    private func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }

        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage:  cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
