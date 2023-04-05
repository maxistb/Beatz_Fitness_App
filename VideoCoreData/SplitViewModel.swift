//
//  SplitViewModel.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 05.04.23.
//

import CoreData

class SplitViewModel: ObservableObject {
    private var dataController = DataController(name: "Model")
    @Published var splits = [Split]()
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        let request = NSFetchRequest<Split>(entityName: "Split")
        request.sortDescriptors = [            NSSortDescriptor(key: "name", ascending: true)]
        do {
            splits = try dataController.container.viewContext.fetch(request)
        } catch {
            print("Error CoreData")
        }
    }
    
    func addData(name: String) {
        let newSplit = Split(context: dataController.container.viewContext)
        newSplit.id = UUID()
        newSplit.name = name
        
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

