//
//  TubeView.swift
//  ScienceTubeAnimation
//
//  Created by K!shanRaja on 28/08/20.
//  Copyright © 2020 K!shanRaja. All rights reserved.
//

import SwiftUI

struct TubeView: View {
    
    @State var width: CGFloat
    @State var height: CGFloat
    @State var curveHeight: CGFloat = 0
    @State var curveLength: CGFloat
    @State var speed: Double = 1
    @State var color: Color = .orange
    
    @State private var time: Double = 0
    @State private var bubbleTime: Double = 0
    @State private var offsetY = 0
    @State private var animate = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                
                Capsule()
                    .fill(Color.blue.opacity(0.5))
                    .padding(.leading, 6)
                    .padding(.trailing, 6)
                
                Ellipse()
                    .fill(Color.blue.opacity(0.5))
                    .background(Ellipse().foregroundColor(Color.white))
                    .overlay(
                        Ellipse()
                            .stroke(Color.blue, lineWidth: 2)
                )
                    .frame(height: geometry.size.height / 4.5)
                
                BubbleView(delay: 0).offset(x: -5, y: 5)
                BubbleView(delay: 1).offset(x: -18, y: 14)
                BubbleView(delay: 2).offset(x: -13, y: 18)
                BubbleView(delay: 3).offset(x: -11, y: 14)
                BubbleView(delay: 4).offset(x: -11, y: 18)
                BubbleView(delay: 5)
                
                Ellipse()
                    .fill(Color.blue.opacity(0.5))
                    .overlay(
                        Ellipse()
                            .stroke(Color.blue, lineWidth: 4)
                )
                    .frame(width: geometry.size.width - 16, height: (geometry.size.height / 4.5) - 16)
                    .padding(.top, 8)
                    .padding(.leading, 8)
                
                ZStack {
                    WaterWaveFluid(curveHeight: self.curveHeight, curveLength: self.curveLength, time: CGFloat(self.time * 1.2), width: geometry.size.width + 5, height: geometry.size.height)
                        .fill(self.color)
                    
                    WaterWaveFluid(curveHeight: self.curveHeight, curveLength: self.curveLength, time: CGFloat(self.time), width: geometry.size.width + 5, height: geometry.size.height)
                        .fill(self.color)
                        .opacity(0.5)
                }
                .mask(
                    Capsule()
                        .fill(Color.white.opacity(0.5))
                        .padding(.leading, 7)
                        .padding(.trailing, 7)
                        .padding(.bottom, 2)
                )
            }
        }
            
        .onAppear {
            self.offsetY = Int((self.height/2) + self.curveHeight)
            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
                self.time += 0.01
                if self.offsetY >= (-Int((self.height/2) + self.curveHeight)) {
                    if self.animate {
                        withAnimation(Animation.linear(duration: 0.03)) {
                            self.offsetY -= 1
                        }
                    }
                }
            }
        }
    }
}


struct BubbleView: View {
    var delay: Double = 0
    
    @State private var scaleEffect: CGFloat = 0.0
    @State private var opacity: Double = 1
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        Circle()
            .foregroundColor(Color.red)
            //            .fill(Color.white.opacity(0.5))
            
            .scaleEffect(scaleEffect)
            .opacity(opacity)
            .offset(y: offsetY)
            .animation(
                Animation.easeInOut(duration: 5)
                    .repeatCount(1)
                    .repeatForever(autoreverses: false)
                    .delay(delay)
        ).onAppear {
            self.offsetY = -200
            self.opacity = 0
            self.scaleEffect = 0.4
        }
    }
}

struct WaterWaveFluid: Shape {
    let curveHeight: CGFloat
    let curveLength: CGFloat
    var time: CGFloat
    let width: CGFloat
    let height: CGFloat
    
    func path(in rect: CGRect) -> Path {
        return (
            Path{ path in
                path.move(to: CGPoint(x: width, y: height * 2))
                path.addLine(to: CGPoint(x: 0, y: height * 2))
                
                for i in stride(from: 0, to: CGFloat(rect.width), by: 1) {
                    path.addLine(to: CGPoint(x: i, y: sin(((i / rect.height) + time) * curveLength * .pi) * curveHeight + rect.midY))
                }
                path.addLine(to: CGPoint(x: width, y: height * 2))
            }
        )
    }
}

struct TubeView_Previews: PreviewProvider {
    static var previews: some View {
        TubeView(width: 100, height: 100, curveHeight: 100, curveLength: 100, speed: 1)
    }
}
