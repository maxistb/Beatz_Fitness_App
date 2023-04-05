//
//  ContentView.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 05.04.23.
//

import SwiftUI
import CoreData

class SplitViewModel: ObservableObject {
    private var dataController = DataController(name: "Model")
    @Published var splits = [Split]()
    
    init() {
        fetchData()
    }
    func fetchData() {
        let request = NSFetchRequest<Split>(entityName: "Split")
        request.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        do {
            splits = try dataController.container.viewContext.fetch(request)
        } catch {
            print("Error CoreData")
        }
    }
    
    func addData(name: String) {
        let neuerSplit = Split(context: dataController.container.viewContext)
        neuerSplit.id = UUID()
        neuerSplit.name = name
        
        save()
        fetchData()
    }
    func save() {
        try? dataController.container.viewContext.save()
    }
    func delete(offsets: IndexSet) {
        for offset in offsets {
            let split = splits[offset]
            dataController.container.viewContext.delete(split)
        }
        save()
        fetchData()
    }
}

struct ContentView: View {

    @State private var splitsName = ""
    @StateObject var splitsVM = SplitViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(splitsVM.splits) { split in
                    Text(split.name ?? "Error")
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
