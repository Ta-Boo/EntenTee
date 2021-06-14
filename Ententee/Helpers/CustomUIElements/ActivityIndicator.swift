//
//  ActivityIndicator.swift
//  Ententee
//
//  Created by hladek on 14/06/2021.
//

import SwiftUI
struct ActivityIndicator: View {
    let style = StrokeStyle(lineWidth: 8, lineCap: .round)
    @State var animate = false

    let primaryColor = Assets.Colors.primary
    let secondaryColor = Assets.Colors.secondary

    var body: some View {
        ZStack {
            GeometryReader { g in
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Assets.Colors.accent.opacity(0.5))
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(
                        AngularGradient(gradient: .init(colors: [primaryColor, secondaryColor]), center: .center),
                        style: style
                    )
                    .rotationEffect(Angle(degrees: animate ? 360 : 0))
                    .animation(Animation.linear(duration: 1.3).repeatForever(autoreverses: false))
                    .padding(g.size.width * 0.2)
            }

        }.onAppear() {
            self.animate.toggle()
        }
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator()
            .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

