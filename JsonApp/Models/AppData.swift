//
//  AppData.swift
//  JsonApp
//
//  Created by Vadim on 26.05.2022.
//

import Foundation

@MainActor
class AppData: ObservableObject {
    
    @Published var users: [User] = []
    
    private var preview: Bool
    
    init(preview: Bool = false) {
        self.preview = preview
    }
    
    func loadData() {
        if preview {
            loadDataFromFile()
        } else {
            Task {
                await loadDataFromUrl(url: "https://www.hackingwithswift.com/samples/friendface.json")
                users.sort {
                    $0.name < $1.name
                }
            }
        }
        
        
    }
    
    func loadDataFromFile() {
        let path = Bundle.main.path(forResource: "data", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try! Data(contentsOf: url)
        decodeJson(data: data)
    }
    
    func loadDataFromUrl(url: String) async {
        guard let url = URL(string: url) else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            decodeJson(data: data)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func decodeJson(data: Data) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            self.users = try decoder.decode([User].self, from: data)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}
