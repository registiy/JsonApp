//
//  Friend.swift
//  JsonApp
//
//  Created by Vadim on 26.05.2022.
//

import Foundation

struct Friend: Identifiable, Codable {
    let id: UUID
    let name: String
}
