//
//  TableView.swift
//  test_ios
//
//  Created by 박준하 on 2023/02/05.
//

import Foundation
import SwiftUI

struct TableView: View {
    var result: Root?
    init(result: Root) {
        self.result = result
    }
    var body: some View {
        VStack {
            if let data = result?.data {
                UserRow(users: data)
            }
        }
    }
}

struct UserRow: View {
    var users: [User]
    
    var body: some View {
        List {
            Section(header: HStack {
                    Text("id").frame(width: (UIScreen.main.bounds.width - 40) / 4)
                    Text("email").frame(width: (UIScreen.main.bounds.width - 40) / 4)
                    Text("name").frame(width: (UIScreen.main.bounds.width - 40) / 4)
                    Text("avatar").frame(width: (UIScreen.main.bounds.width - 40) / 4)
            }) {
                ForEach(users) { oneUser in
                    HStack {
                        Text("\(oneUser.id)").frame(width: (UIScreen.main.bounds.width - 40) / 4)
                        Text("\(oneUser.email)").frame(width: (UIScreen.main.bounds.width - 40) / 4)
                        Text("\(oneUser.firstName) \(oneUser.lastName)").frame(width: (UIScreen.main.bounds.width - 40) / 4)
                        Text("\(oneUser.avatar)").frame(width: (UIScreen.main.bounds.width - 40) / 4)
                    }
                }
            }
        }

    }
}
