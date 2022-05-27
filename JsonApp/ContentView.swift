//
//  ContentView.swift
//  JsonApp
//
//  Created by Vadim on 24.05.2022.
//

import SwiftUI

enum SortBy: String, CaseIterable {
    case name = "Name"
    case secondName = "Second Name"
    case online = "Online"
}

enum SortOrder: String, CaseIterable {
    case asc = "Asc"
    case desc = "Desc"
}

struct ContentView: View {
    
    @StateObject var appData: AppData
    
    @State private var sortBy: SortBy = .name
    @State private var sortOrder: SortOrder = .asc
    
    @State private var searchText: String = ""
    
    init(preview: Bool = false) {
        _appData = StateObject(wrappedValue: AppData(preview: preview))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    TextField("Search", text: $searchText)
                    
                    Picker("Sort by", selection: $sortBy) {
                        ForEach(SortBy.allCases, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }.pickerStyle(.segmented)
                    
                    Picker("Sort order", selection: $sortOrder) {
                        ForEach(SortOrder.allCases, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }.pickerStyle(.segmented)
                    
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
            .onChange(of: sortBy, perform: { newSortBy in
                appData.sortUsers(sortBy: sortBy, sortOrder: sortOrder)
            })
            .onChange(of: sortOrder, perform: { newSortOrder in
                appData.sortUsers(sortBy: sortBy, sortOrder: sortOrder)
            })
            .onChange(of: searchText, perform: { newSearchText in
                appData.searchUsers(text: searchText)
            })
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
