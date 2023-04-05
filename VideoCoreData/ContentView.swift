//
//  ContentView.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 05.04.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var splitsName = ""
    @StateObject var splitsVM = SplitViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(splitsVM.splits) { split in
                    NavigationLink(destination: ÜbungsView(split: split)) {
                        Text(split.name ?? "Error")
                    }
                }
                .onDelete(perform: deleteSplit)
            }
            
            HStack {
                TextField("Neuer Split", text: $splitsName)
                Button("Hinzufügen") {
                    splitsVM.addData(name: splitsName)
                    splitsName = ""
                }
            }
        }
        .padding()
    }
    
    func deleteSplit(at offsets: IndexSet) {
        splitsVM.delete(offsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
