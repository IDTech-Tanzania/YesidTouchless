//
//  YesidTouchless.swift
//  yesid
//
//  Created by Emmanuel Mtera on 11/9/22.
//

import Foundation
import SwiftUI

struct YesidTouchless: UIViewControllerRepresentable {
    
    @State var orientation:UInt32 = 0
    @State var progress:UInt32 = 0
    @State var controller = ViewController()
    @EnvironmentObject var viewModel: TouchlessViewModel
    
    typealias UIViewControllerType = ViewController
    
    func makeUIViewController(context: Context) -> ViewController {
        controller.orientation = orientation
        controller.viewModel = viewModel
        controller.progress = progress
        return controller
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
    
}
