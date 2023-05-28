///
//  ContentView.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 05.04.23.
//

import SwiftUI
import CoreData

struct SplitView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Split.order, ascending: true)]) var splits: FetchedResults<Split>
    @State private var name = ""
    @State private var isEditMode = false
    @State private var showAddSplitView = false
    @State private var settingsDetent = PresentationDetent.medium
    @State public var vordefinierteSplitsMänner: [VordefinierteSplits] = [
            VordefinierteSplits(
                name: "Push",
                uebungen: [
                    UebungsItem(uebungName: "Brustpresse", uebungBeschreibung: "Brust", anzahlSaetze: 3, bild: Image("Brustpresse")),
                    UebungsItem(uebungName: "Butterfly", uebungBeschreibung: "Brust", anzahlSaetze: 3, bild: Image("Butterfly")),
                    UebungsItem(uebungName: "Seitheben", uebungBeschreibung: "Schultern", anzahlSaetze: 3, bild: Image("Seithebenmaschine")),
                    UebungsItem(uebungName: "Schulterpresse", uebungBeschreibung: "Schultern", anzahlSaetze: 3, bild: Image("FullSizeRender")),
                    UebungsItem(uebungName: "Trizeps Pushdown", uebungBeschreibung: "Trizeps", anzahlSaetze: 3, bild: Image("Butterfly"))
                ]
            ),
            VordefinierteSplits(
                name: "Pull",
                uebungen: [
                    UebungsItem(uebungName: "Latzug", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("Latzug")),
                    UebungsItem(uebungName: "T-Bar Row", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("T-Bar")),
                    UebungsItem(uebungName: "Highrow", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("Highrow")),
                    UebungsItem(uebungName: "Rückenstrecker", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("Reverse_Butterfly")),
                    UebungsItem(uebungName: "Reverse Butterfly", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("Reverse_Butterfly")),
                    UebungsItem(uebungName: "Bizepsmaschine", uebungBeschreibung: "Bizeps", anzahlSaetze: 3, bild: Image("Reverse_Butterfly")),
                ]
            ),
            VordefinierteSplits(
                name: "Oberkörper",
                uebungen: [
                    UebungsItem(uebungName: "T-Bar Row", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("T-Bar")),
                    UebungsItem(uebungName: "Rudern", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("Rudern")),
                    UebungsItem(uebungName: "Latzug", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("Latzug")),
                    UebungsItem(uebungName: "Butterfly", uebungBeschreibung: "Brust", anzahlSaetze: 3, bild: Image("Butterfly")),
                    UebungsItem(uebungName: "Bankdrückmaschine", uebungBeschreibung: "Brust", anzahlSaetze: 3, bild: Image("Bankdrückmaschine"))
                ]
            ),
            VordefinierteSplits(
                name: "Unterkörper",
                uebungen: [
                    UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Beine", anzahlSaetze: 3, bild: Image("Hacksquat")),
                    UebungsItem(uebungName: "Beinpresse", uebungBeschreibung: "Beine", anzahlSaetze: 3, bild: Image("Beinpresse")),
                    UebungsItem(uebungName: "Beinbeuger", uebungBeschreibung: "Beine", anzahlSaetze: 3, bild: Image("Beinpresse")),
                    UebungsItem(uebungName: "Wadenmaschine", uebungBeschreibung: "Waden", anzahlSaetze: 3, bild: Image("Wadenmaschine_alt"))
                ]
            ),
            VordefinierteSplits(
                name: "Ganzkörper",
                uebungen: [
                    UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Beine", anzahlSaetze: 3, bild: Image("Hacksquat")),
                    UebungsItem(uebungName: "Rudern", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("Rudern")),
                    UebungsItem(uebungName: "Butterfly", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("Butterfly")),
                    UebungsItem(uebungName: "Bankdrückmaschine", uebungBeschreibung: "Brust", anzahlSaetze: 3, bild: Image("Bankdrückmaschine")),
                    UebungsItem(uebungName: "Schulterpresse", uebungBeschreibung: "Schultern", anzahlSaetze: 3, bild: Image("FullSizeRender"))
                ]
            ),
        ]

     @State public var vordefinierteSplitsFrauen: [VordefinierteSplits] = [
          VordefinierteSplits(
              name: "Beine",
              uebungen: [
                  UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 3, bild: Image("Hacksquat")),
                  UebungsItem(uebungName: "Beinpresse", uebungBeschreibung: "Für den Lat", anzahlSaetze: 3, bild: Image("Beinpresse")),
                  UebungsItem(uebungName: "Beinbeuger", uebungBeschreibung: "Für den Lat", anzahlSaetze: 3, bild: Image("Beinpresse")),
                  UebungsItem(uebungName: "Beinstrecker schwer", uebungBeschreibung: "Für die Quads", anzahlSaetze: 3, bild: Image("Beinstrecker_neu")),
                  UebungsItem(uebungName: "Adduktormaschine", uebungBeschreibung: "Für die Adduktoren", anzahlSaetze: 3, bild: Image("Adduktormaschine")),
                  UebungsItem(uebungName: "Wadenmaschine", uebungBeschreibung: "Für die Waden", anzahlSaetze: 3, bild: Image("Wadenmaschine_alt")),
              ]
          ),
          ]

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Eigene Splits")) {
                        ForEach(splits.indices, id: \.self) { index in
                            let split = splits[index]
                            NavigationLink(destination: UebungView(split: split)) {
                                if isEditMode {
                                    TextField("Split Name", text: Binding(
                                        get: {
                                            split.name ?? ""
                                        },
                                        set: { newName in
                                            updateSplitName(split: split, newName: newName)
                                        }
                                    ))
                                } else {
                                    Text(split.name ?? "Error")
                                }
                            }
                            .swipeActions {
                                Button(action: {
                                    deleteItems(at: IndexSet([index]))
                                }, label: {
                                    Image(systemName: "trash")
                                })
                                .tint(.red)
                            }
                        }
                        .onMove(perform: moveItems)
                        .onDelete(perform: deleteItems)
                        
                    }
                    Section(header: Text("Empfohlene Trainingspläne Männer")) {
                        ForEach(vordefinierteSplitsMänner, id: \.name) { split in
                            NavigationLink(destination: VordefinierteSplitView(split: split)) {
                                Text(split.name)
                            }
                        }
                    }
                    
                    Section(header: Text("Empfohlene Trainingspläne Frauen")) {
                        ForEach(vordefinierteSplitsFrauen, id: \.name) { split in
                            NavigationLink(destination: VordefinierteSplitView(split: split)) {
                                Text(split.name)
                            }
                        }
                    }
                }
                .navigationBarTitle("Trainingspläne")
                .navigationBarItems(leading:
                                        Button(action: {
                    withAnimation {
                        isEditMode.toggle()
                    }
                }) {
                    Text(isEditMode ? "Fertig" : "Bearbeiten")
                }
                )
                .environment(\.editMode, isEditMode ? .constant(.active) : .constant(.inactive))
                .navigationBarItems(trailing:
                                        Button(action: {
                    showAddSplitView = true
                }) {
                    Image(systemName: "plus")
                }
                )
            }
            .sheet(isPresented: $showAddSplitView) {
                NavigationView {
                    AddSplitView(name: $name)
                        .navigationBarBackButtonHidden(true)
                }
                .presentationDetents(
                    [.medium, .large],
                    selection: $settingsDetent
                )
                .navigationViewStyle(StackNavigationViewStyle())
            }
            .navigationTitle("Split hinzufügen")
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplitView()
    }
}
