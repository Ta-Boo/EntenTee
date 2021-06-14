//
//  UsersViewModel.swift
//  Ententee
//
//  Created by hladek on 14/06/2021.
//

import Foundation

class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var loading = false
    @Published var selectedUser: User?

    let api = API.shared

    func fetchData(){
        loading = true
        api.fetchUsers{ [weak self] result in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self?.users = users // in case of pagination, can be just added
                    self?.loading = false
                }
            case .failure(let error):
                print(error.localizedDescription)
                self?.loading = false
            }
        }
    }
}
