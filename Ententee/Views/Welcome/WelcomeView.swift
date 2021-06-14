//
//  ContentView.swift
//  Ententee
//
//  Created by hladek on 11/06/2021.
//

import SwiftUI


struct WelcomeView: View {
    @ObservedObject var viewModel: WelcomeViewModel = WelcomeViewModel()

    var body: some View {

        GeometryReader { geometry in
            VStack{
                Spacer()
                    .frame( height: 32)
                Assets.Icons.sowl
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Spacer()
                    .frame( height: 32)
                Text("Welcome,\n\(UIDevice.current.name)")
                    .foregroundColor(Assets.Colors.text)
                    .font(.bold(.title)())
                    .multilineTextAlignment(.center)
                HStack {
                    Spacer()
                }
                Spacer()
                Button(action: {
                    viewModel.authenticateUser()
                }){
                    Assets.Icons.fingerprint
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                }.alert(isPresented: $viewModel.showAlert) {
                    Alert(.dismiss(viewModel.alert!)) // getting triggered after alert is assigned, so there is no chance to fail force unwrap
                }
                Spacer()
                    .frame( height: 32)
            }
            .background(
                Assets.Colors.primary.ignoresSafeArea(.all)
            )
        }
        .preferredColorScheme(.light)
        .navigate(to: UsersView(), when: $viewModel.authenticated)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let displayType = "iPhone SE"
        WelcomeView()
            .navigationBarHidden(true)
            .previewDevice(PreviewDevice(rawValue: displayType))
            .previewDisplayName(displayType)
    }
}
