//
//  ListView.swift
//  Ententee
//
//  Created by hladek on 14/06/2021.
//

import SwiftUI

struct UsersView: View {
    @ObservedObject var viewModel: UsersViewModel = UsersViewModel()

    init() {
       UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
       UITableView.appearance().backgroundColor = .clear
    }

    var body: some View {
        ZStack {
            Assets.Colors.primary.ignoresSafeArea(.all)
            List {
                ForEach(viewModel.users, id: \.id){ user in
                    UserRow(user: user).onTapGesture {
                        viewModel.selectedUser = user
                    }
                }
                .background(
                    Assets.Colors.primary.ignoresSafeArea(.all)
                )

            }

            if(viewModel.loading) {
                ActivityIndicator()
                    .frame(width: 100, height: 100, alignment: .center)
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.fetchData()
                    }, label: {
                        Assets.Icons.refresh
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding()
                            .offset()
                            .scaledToFit()
                            .background(Assets.Colors.accent)
                            .clipShape(Circle())
                    })
                }
            }.padding()

        }
        .onAppear{
            viewModel.fetchData()
        }
        .background(
            Assets.Colors.primary.ignoresSafeArea(.all)
        )
        .sheet(item: $viewModel.selectedUser) { user in
            UserView(user: user)
        }

    }
}

struct UserstView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}


