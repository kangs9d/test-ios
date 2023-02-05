//
//  DetailView.swift
//  test_ios
//
//  Created by 박준하 on 2023/02/05.
//

import SwiftUI

struct Root: Decodable {
    let page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    let data: [User]
    let support: Support

    private enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data
        case support
    }
}

struct User: Decodable, Identifiable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String

    private enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

struct Support: Decodable {
    let url: String
    let text: String
}
struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var result: Root? = nil
    var checked: Bool
    
    init(checked: Bool) {
        self.checked = checked
    }
    var body: some View {
        VStack {
            if let result = result {
                TableView(result: result)
            } else {
                VStack {
                    self.checked ? Text("It is checked") : Text("Unchecked")
                    Button(action: {self.makeRequest()}) {
                        Text("make Request")
                    }
                }
                
            }}
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Dismiss")
                }
            )
        
    }
    
    func makeRequest() {
        let url = URL(string: "https://reqres.in/api/users?page=2")!
        let decoder = JSONDecoder()
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            }
            if let data = data {
                let stringData = String(decoding: data, as: UTF8.self)
                guard let json = stringData.data(using: .utf8) else {return}
                do {
                    let data = try decoder.decode(Root.self, from: json)
                    self.result = data
                } catch let error {
                    print("Error decoding JSON: \(error)")
                }
                
            }
        }
        task.resume()
    }
}
