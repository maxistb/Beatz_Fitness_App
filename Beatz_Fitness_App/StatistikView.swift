//
//  StatistikView.swift
////  Beatz_Fitness_App
////
////  Created by Maximillian Stabe on 17.05.23.
////
//
//import SwiftUI
//import SwiftUICharts
//
//struct StatistikView: View {
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: GewichteNachUebung.entity(),
//                  sortDescriptors: [NSSortDescriptor(keyPath: \GewichteNachUebung.timestamp, ascending: true)])
//    var gewichte: FetchedResults<GewichteNachUebung>
//    
//    var body: some View {
//        VStack {
//            if !gewichte.isEmpty {
//                LineChartView(data: GewichteNachUebung., title: "Test")
//                    .frame(height: 300)
//                    .padding()
//            } else {
//                Text("Keine Daten verfügbar")
//            }
//        }
//    }
//}


//func getWiederholungenUndGewichte(ausgefuehrteSätzeNachUebung: [String: [AusgefuehrterSatz]]) -> [String: (wiederholungen: [Int], gewichte: [Double])] {
//    var result: [String: (wiederholungen: [Int], gewichte: [Double])] = [:]
//
//    for (uebungname, ausgefuehrteSätze) in ausgefuehrteSätzeNachUebung {
//        var wiederholungen: [Int] = []
//        var gewichte: [Double] = []
//
//        for satz in ausgefuehrteSätze {
//            wiederholungen.append(Int(satz.wiederholungen))
//            gewichte.append(satz.gewicht)
//        }
//
//        result[uebungname] = (wiederholungen: wiederholungen, gewichte: gewichte)
//    }
//
//    return result
//}



