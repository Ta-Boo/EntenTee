//
//  User.swift
//  Ententee
//
//  Created by hladek on 14/06/2021.
//

import SwiftUI
import MapKit

struct UserView: View {
    var user: User
    var body: some View {
        GeometryReader { g in
            VStack {
                HStack(spacing: 32) {
                    Assets.Icons.avatar
                        .resizable()
                        .background(Assets.Colors.secondary)
                        .clipShape(Circle())
                        .frame(width: 128, height: 128)
                    VStack(alignment: .leading, spacing: 8) {
                        Text(user.username)
                            .foregroundColor(Assets.Colors.text)
                            .font(.title)
                        Text(user.name)
                            .foregroundColor(Assets.Colors.text)
                            .font(.title3)
                        Text(user.email)
                            .foregroundColor(Assets.Colors.text)
                            .font(.title3)
                            .lineLimit(1)
                    }

                    Spacer()
                }.padding()
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(user.company.name)
                            .foregroundColor(Assets.Colors.text)
                            .font(.title)
                        Text(user.company.catchPhrase)
                            .foregroundColor(Assets.Colors.text)
                            .font(.title3)
                        Text(user.website)
                            .foregroundColor(Assets.Colors.text)
                            .font(.title3)
                            .padding(.bottom, 4)
                        Text(user.address.street)
                            .foregroundColor(Assets.Colors.text)
                            .font(.footnote)
                        Text(user.address.suite)
                            .foregroundColor(Assets.Colors.text)
                            .font(.footnote)
                        Text(user.address.city)
                            .foregroundColor(Assets.Colors.text)
                            .font(.footnote)
                    }.padding(.horizontal, 16)
                    Spacer()
                }
                Spacer()
                if let lat = Double(user.address.geo.lat), let lng = Double(user.address.geo.lng) {

                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lng), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))), interactionModes: [.zoom])
                        .frame(height: g.size.height * 0.35)
                        .cornerRadius(10)
                        .padding()
                }

                HStack{
                    Spacer()
                }
            }
            .background(
                Assets.Colors.accent.ignoresSafeArea(.all)
        )
        }
    }
}

struct UserInfoRowView: View {
    let label: String
    let data: String
    var body: some View {
        HStack(spacing: 10) {
            Text(label)
            
            Text(data)
        }
        .padding(.horizontal)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User(id: 1, name: "jan", username: "Sova",email: "asd@asd.as", address: Address(street: "Hlavna", suite: "Unknown", city: "Komjatna", zipcode: "034 96", geo: GEO(lat: "19.133", lng: "21.331")), phone: "0948194877", website: "github.com", company: Company(name: "Rapoo", catchPhrase: "Unknown", bs: "Unknown")))
    }
}
