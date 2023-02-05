//
//  ContentView.swift
//  test_ios
//
//  Created by 박준하 on 2023/02/04.
//

import SwiftUI
struct CheckBoxView: View {
    @Binding var checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
            .onTapGesture {
                self.checked.toggle()
            }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    struct CheckBoxViewHolder: View {
        @State var checked = false

        var body: some View {
            CheckBoxView(checked: $checked)
        }
    }

    static var previews: some View {
        CheckBoxViewHolder()
    }
}

struct ContentView: View {
    @State private var checked = true
    @State private var showDetail = false
    var body: some View {
        NavigationView {
                VStack {
                    HStack {
                        VStack {
                            NavigationLink(destination: DetailView(checked:checked)) {
                                Text("Go to Detail View")
                            }
                        }
                        Button(action: {self.showDetail = true}) {
                            HStack {
                                Image(systemName: "star.fill")
                                Text("Button to go to detail view")
                            }
                        }.sheet(isPresented: self.$showDetail) {
                            NavigationView {
                                DetailView(checked:checked)
                            }
                        }
                    }
                    HStack {
                        CheckBoxView(checked: $checked)
                            .padding([.top, .leading, .bottom], 10.0)
                        Text("checkbox here")
                    }
                }
            .navigationBarTitle("Main View")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
