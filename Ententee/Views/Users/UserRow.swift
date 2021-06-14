//
//  UserRow.swift
//  Ententee
//
//  Created by hladek on 14/06/2021.
//

import SwiftUI

struct UserRow: View {
    let user: User
    let fakeStuff = ["Developer", "Epidemiologist", "Nurse", "Doctor", "Teacher", "Baking", "Basketball", "Baton twirling", "Beatboxing", "Beer tasting", "Binge-watching", "Blogging", "Board/tabletop games", "Book restoration", "Bowling", "Jiu-jitsu", "Breadmaking"]
    var body: some View {
        HStack{
            Text(user.username.prefix(1))
                .frame(width: 36, height: 36)
                .font(.title)
                .padding()
                .background(Assets.Colors.accent)
                .cornerRadius(50)
                .foregroundColor(Assets.Colors.text)

            VStack(alignment: .leading){
                Text(user.username)
                    .foregroundColor(Assets.Colors.text)
                    .font(.bold(.title2)())
                    .padding(.bottom, 4)
                Text(user.phone)
                    .foregroundColor(Assets.Colors.text)
                    .font(.footnote)
                HStack {
                    Assets.Icons.pin
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                    Text(user.address.city)
                        .foregroundColor(Assets.Colors.text)
                        .font(.footnote)
                }
                HStack{
                    Text(user.email)
                        .font(.caption)
                        .padding(6)
                        .background(Assets.Colors.accent)
                        .cornerRadius(10)
                        .foregroundColor(Assets.Colors.text)
                        .lineLimit(1)
                }
            }
            .padding(.horizontal)
            Spacer()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .listRowBackground(Color.clear)
        .background(Assets.Colors.secondary)
        .cornerRadius(10)
    }
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Assets.Colors.primary
            VStack {
                UserRow(user: User(id: 1, name: "jan", username: "Sova",email: "asd@asd.as", address: Address(street: "Hlavna", suite: "Unknown", city: "Komjatna", zipcode: "034 96", geo: GEO(lat: "19.133", lng: "21.331")), phone: "0948194877", website: "github.com", company: Company(name: "Rapoo", catchPhrase: "Unknown", bs: "Unknown")))
                //                UserRow(user: User(id: 2, name: "jan", username: "Sova", address: Address(street: "Hlavna", suite: "Unknown", city: "Komjatna", zipcode: "034 96", geo: GEO(lat: "19.133", lng: "21.331")), phone: "0948194877", website: "github.com", company: Company(name: "Rapoo", catchPhrase: "Unknown", bs: "Unknown")))
            }
        }
    }
}
