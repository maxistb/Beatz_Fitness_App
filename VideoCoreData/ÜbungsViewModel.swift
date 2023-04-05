//
//  SplitViewModel.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 05.04.23.
//

import CoreData

class ÜbungsViewModel: ObservableObject {
    private var dataController = DataController(name: "Model")
    @Published var uebungen = [Uebung]()
    var split: Split
    
    init(split: Split) {
        self.split = split
        fetchData()
    }

    func fetchData() {
        let request = NSFetchRequest<Uebung>(entityName: "Uebung")
        request.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        do {
            uebungen = try dataController.container.viewContext.fetch(request)
        } catch {
            print("Error CoreData")
        }
    }
    
    func addData(name: String) {
        let neueUebung = Uebung(context: dataController.container.viewContext)
        neueUebung.id = UUID()
        neueUebung.name = name
        
        save()
        fetchData()
    }
    func save() {
        try? dataController.container.viewContext.save()
    }
    func delete(offsets: IndexSet) {
        for offset in offsets {
            let uebung = uebungen[offset]
            dataController.container.viewContext.delete(uebung)
        }
        save()
        fetchData()
    }

}

