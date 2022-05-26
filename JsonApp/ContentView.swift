//
//  ContentView.swift
//  JsonApp
//
//  Created by Vadim on 24.05.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var appData: AppData
    
    init(preview: Bool = false) {
        _appData = StateObject(wrappedValue: AppData(preview: preview))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(appData.users, id: \.id) { user in
                        NavigationLink {
                            UserView(user: user)
                        } label: {
                            HStack {
                                Circle()
                                    .strokeBorder(.black, lineWidth: 2)
                                    .background(Circle().fill(user.isActive ? .green : .red) )
                                    .frame(width: 15)
                            }
                            Text("\(user.name)")
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .navigationTitle("Users list")
            .task {
                appData.loadData()
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView(preview: true)
    }
}
