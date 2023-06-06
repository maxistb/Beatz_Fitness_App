//
//  TrainingseintragDetail.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 27.04.23.
//

import SwiftUI
import CoreData

struct TrainingseintragDetailView: View {
    var trainingseintrag: Trainingseintrag
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @FocusState var isInputActive: Bool
    @FetchRequest(entity: Trainingseintrag.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Trainingseintrag.order, ascending: true)])
    var trainingseinträge: FetchedResults<Trainingseintrag>
    var ausgefuehrteSätzeNachUebung: [String: [AusgefuehrterSatz]] {
        Dictionary(grouping: trainingseintrag.ausgefuehrteSätzeArray.sorted(by: { $0.satzIndex < $1.satzIndex })) { $0.uebungname ?? "Fehler" }
    }
    @State private var gewichte: [Double] = []
    @State private var wiederholungen: [Int] = []
    
    init(trainingseintrag: Trainingseintrag) {
           self.trainingseintrag = trainingseintrag
           _gewichte = State(initialValue: saveGewichteUndWiederholungen().0)
           _wiederholungen = State(initialValue: saveGewichteUndWiederholungen().1)
       }
    
    var body: some View {
            List {
                ForEach(Array(ausgefuehrteSätzeNachUebung.keys.sorted(by: { (uebungname1, uebungname2) -> Bool in
                    let satzIndex1 = ausgefuehrteSätzeNachUebung[uebungname1]?.first?.satzIndex ?? 0
                    let satzIndex2 = ausgefuehrteSätzeNachUebung[uebungname2]?.first?.satzIndex ?? 0
                    return satzIndex1 < satzIndex2
                })), id: \.self) { uebungname in
                    Section(header: Text(uebungname)) {
                    ForEach(ausgefuehrteSätzeNachUebung[uebungname]!, id: \.self) { ausgefuehrterSatz in
                        HStack {
                            if let ausgefuehrterSatz = ausgefuehrteSätzeNachUebung[uebungname]?.first(where: { $0.id == ausgefuehrterSatz.id }) {
                                if ausgefuehrterSatz.isDropsatz {
                                    Section(header: Text("Dropsatz")) {
                                        createGewichtTextField(for: ausgefuehrterSatz)
                                            .introspectTextField { (textField) in
                                                let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                                let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                                let doneButton = UIBarButtonItem(title: "Fertig", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                                                doneButton.tintColor = UIColor.init(Color(red: 0/255, green: 166/255, blue: 205/255))
                                                toolBar.items = [flexButton, doneButton]
                                                toolBar.setItems([flexButton, doneButton], animated: true)
                                                textField.inputAccessoryView = toolBar
                                            }

                                    }
                                } else if ausgefuehrterSatz.isAufwaermsatz {
                                    Section(header: Text("Aufwärm.")) {
                                        createGewichtTextField(for: ausgefuehrterSatz)
                                            .introspectTextField { (textField) in
                                                let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                                let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                                let doneButton = UIBarButtonItem(title: "Fertig", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                                                doneButton.tintColor = UIColor.init(Color(red: 0/255, green: 166/255, blue: 205/255))
                                                toolBar.items = [flexButton, doneButton]
                                                toolBar.setItems([flexButton, doneButton], animated: true)
                                                textField.inputAccessoryView = toolBar
                                            }

                                    }
                                } else {
                                    createGewichtTextField(for: ausgefuehrterSatz)
                                        .introspectTextField { (textField) in
                                            let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                            let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                            let doneButton = UIBarButtonItem(title: "Fertig", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                                            doneButton.tintColor = UIColor.init(Color(red: 0/255, green: 166/255, blue: 205/255))
                                            toolBar.items = [flexButton, doneButton]
                                            toolBar.setItems([flexButton, doneButton], animated: true)
                                            saveGewichte(trainingseintrag: trainingseintrag)
                                            print(saveGewichte(trainingseintrag: trainingseintrag))
//                                            print(ausgefuehrteSätzeNachUebung)
                                            textField.inputAccessoryView = toolBar
                                        }

                                }
                                createWiederholungenTextField(for: ausgefuehrterSatz)
                                    .introspectTextField { (textField) in
                                        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                        let doneButton = UIBarButtonItem(title: "Fertig", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                                        doneButton.tintColor = UIColor.init(Color(red: 0/255, green: 166/255, blue: 205/255))
                                        toolBar.items = [flexButton, doneButton]
                                        toolBar.setItems([flexButton, doneButton], animated: true)
                                        textField.inputAccessoryView = toolBar
                                    }

                                Spacer()
                            }
                        }
                        
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                delete(ausgefuehrterSatz: ausgefuehrterSatz)
                            } label: {
                                Label("Löschen", systemImage: "trash")
                            }
                        }
                    }
                    .onMove(perform: move)
                    Button(action: {
                        withAnimation {
                            let neuerSatz = AusgefuehrterSatz(context: moc)
                            neuerSatz.uebungname = uebungname
                            neuerSatz.datum = Date()
                            neuerSatz.id = UUID()
                            neuerSatz.satzIndex = getNextSatzIndex()

//                            print("\(neuerSatz.uebungname): \(neuerSatz.satzIndex)")
                            trainingseintrag.addToAusgefuehrteUebungen(neuerSatz)
                            try? moc.save()
                        }
                    }) {
                        Text("Hinzufügen")
                            .foregroundColor(Color(red: 0/255, green: 166/255, blue: 205/255))
                    }
                }
            }
            Section(header: Text("Notizen")) {
                TextField("", text: Binding(
                    get: {
                        trainingseintrag.notizen 
                    },
                    set: { newValue in
                        trainingseintrag.notizen = newValue
                        try? moc.save()
                    }
                ), axis: .vertical)
                .focused($isInputActive)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Fertig") {
                            isInputActive = false
                            try? moc.save()
                        }
                    }
                }
            }
        }
        .navigationTitle(trainingseintrag.split.name ?? "")
    }
}
