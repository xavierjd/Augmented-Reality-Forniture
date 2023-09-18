//
//  ContentView.swift
//  ARForniture
//
//  Created by xavier on 07/09/23.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    
    @StateObject private var vm =  FurnitureViewModel()
    
    let furnitures = ["sofa", "chair", "table", "armoire"]
    
    var body: some View {
        VStack {
            ARViewContainer(vm: vm).edgesIgnoringSafeArea(.all)
        
            ScrollView(.horizontal) {
                HStack {
                    ForEach(furnitures, id: \.self) {  name in
                        Image(name)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .border(.blue, width: vm.selectedForniture == name ? 1.5 : 0.0)
                            .onTapGesture {
                                vm.selectedForniture = name
                            }
                    }
                }
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    let vm: FurnitureViewModel
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.tapped)))
        context.coordinator.arView = arView
        
        return arView
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(vm: vm)
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
