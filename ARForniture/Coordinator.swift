//
//  Coordinator.swift
//  ARForniture
//
//  Created by xavier on 07/09/23.
//

import Foundation
import ARKit
import RealityKit

class Coordinator {
    var arView: ARView?
    var mainScene: Experience.MainScene
    var vm: FurnitureViewModel
    
    init(vm: FurnitureViewModel) {
        self.vm = vm
        self.mainScene = try! Experience.loadMainScene()
    }
    
    @objc func tapped(_ recognizer: UITapGestureRecognizer) {
        
        guard let arView = arView else {
            return
        }
        let location = recognizer.location(in: arView)
        let result = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let result = result.first {
            let anchor = AnchorEntity(raycastResult: result)
            guard let entity = mainScene.findEntity(named: vm.selectedForniture) else { return }
            entity.position = SIMD3(0,0,0)
            
            anchor.addChild(entity)
            arView.scene.addAnchor(anchor)
            
        }
    }
}
