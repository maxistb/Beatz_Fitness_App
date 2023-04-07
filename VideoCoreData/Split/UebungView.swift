//
//  SplitDetail.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 07.04.23.
//

import SwiftUI

struct UebungView: View {
    @Environment(\.managedObjectContext) var moc
    @StateObject var split: Split
    @State private var name = ""
    
    var body: some View {
        VStack {
            List(split.getUebungen) { uebung in
                HStack {
                    Text(uebung.name ?? "Error")
                    Text("\(uebung.saetze) Sätze")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
            }
            .navigationBarTitle(Text(split.name ?? "Error"))
            .navigationBarItems(trailing:
                NavigationLink(destination: AddUebungView(split: split)) {
                    Image(systemName: "plus")
                }
            )
        }
    }
}






