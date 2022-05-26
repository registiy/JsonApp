//
//  UserView.swift
//  JsonApp
//
//  Created by Vadim on 25.05.2022.
//

import SwiftUI

struct UserView: View {
    
    @State var user: User
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Circle()
                    .frame(width: 30)
                    Text(user.isActive ? "Online! Chat now" : "Offline")
                }.foregroundColor(user.isActive ? .green : .red)
                
                Text("Age: \(user.age)")
                
                Text("Registered: \(user.registered)")
                
                Text("Address: \(user.address)")
                
                
                
                Text("\(user.about)")
                    .padding(.vertical)
                
                Text("Friends")
                    .font(.headline)
                    .padding(.bottom, 2)
                
                ForEach(user.friends, id: \.id) { friend in
                    NavigationLink {
                        
                    } label: {
                        Text("\(friend.name)")
                    }
                }
                
                Text("Tags: ")
                    
                ForEach(user.tags, id: \.self) { tag in
                    Text("\(tag)").foregroundColor(.white).padding(.horizontal, 10)
                        .background(Capsule())
                }
                
                
            }.padding()
        }.navigationTitle(user.name)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        
        let appData = AppData(preview: true)
        appData.loadData()
        
        return NavigationView {
            UserView(user: appData.users[0])
        }
    }
}
