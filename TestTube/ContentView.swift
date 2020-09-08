//
//  ContentView.swift
//  TestTube
//
//  Created by K!shanRaja on 08/09/20.
//  Copyright © 2020 K!shanRaja. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.green.opacity(0.5)
            TubeView(width: 100.0, height: 50, curveHeight: 10, curveLength: 1.5, speed: 0.4, color: .red)
            .frame(width: 100, height: 250)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
