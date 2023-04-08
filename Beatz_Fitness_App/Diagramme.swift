//
//  Diagramme.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 24.03.23.
//

import SwiftUI
import Charts

struct Diagramme: View {
    @State private var zielGewicht = ""
    @State private var gewichtEingabe = ""
    @State private var zeigtTextfeld = false
    
        let viewMonths: [ViewMonth] = [
            .init(datum: Date.from(year: 2023, month: 1, day: 1), nameÜbung: "Bankdrücken", gewicht: 10),
            .init(datum: Date.from(year: 2023, month: 2, day: 1), nameÜbung: "Bankdrücken", gewicht: 20),
            .init(datum: Date.from(year: 2023, month: 3, day: 1), nameÜbung: "Bankdrücken", gewicht: 30),
            .init(datum: Date.from(year: 2023, month: 4, day: 1), nameÜbung: "Bankdrücken", gewicht: 40),
            .init(datum: Date.from(year: 2023, month: 5, day: 1), nameÜbung: "", gewicht: 70),
            .init(datum: Date.from(year: 2023, month: 6, day: 1), nameÜbung: "", gewicht: 60),
            .init(datum: Date.from(year: 2023, month: 7, day: 1), nameÜbung: "", gewicht: 50),
            .init(datum: Date.from(year: 2023, month: 8, day: 1), nameÜbung: "", gewicht: 40),
            .init(datum: Date.from(year: 2023, month: 9, day: 1), nameÜbung: "", gewicht: 40),
            .init(datum: Date.from(year: 2023, month: 10, day: 1), nameÜbung: "", gewicht: 30),
            .init(datum: Date.from(year: 2023, month: 11, day: 1), nameÜbung: "", gewicht: 20),
            .init(datum: Date.from(year: 2023, month: 12, day: 1), nameÜbung: "", gewicht: 10)
        ]
  
    
    var body: some View {
        let durchschnitt = viewMonths.reduce(0, { $0 + $1.gewicht / 12})

        VStack {
            
            Button(action: {
                
            }, label: {
                Text("Gewicht eingeben")
                .padding()
                .background(Color.blue.cornerRadius(10).shadow(radius: 10))
                
            })
            

            
            Text("Bankdrücken Fortschritte")
            Text("Durchschnittsgewicht: \(String(format: "%.2f", locale: Locale(identifier: "de_DE"), durchschnitt))kg")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 12)
            
            Chart {
                RuleMark(y: .value("Goal", zielGewicht))
                    .foregroundStyle(Color.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .annotation(alignment: .leading) {
                        Text("Ziel: \(zielGewicht)kg")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                
                ForEach(viewMonths) { viewMonth in
                    BarMark(
                        x: .value("Month", viewMonth.datum, unit: .month),
                        y: .value("Views", viewMonth.gewicht))
                            }
                .foregroundStyle(Color.pink.gradient)
                .cornerRadius(5)
                }
            .frame(height: 180)
            .chartXAxis {
                AxisMarks(values: viewMonths.map { $0.datum }) {datum in
                    AxisValueLabel(format: .dateTime.month(.narrow), centered: true)
                    AxisTick()
                    AxisGridLine()
                }
            }
            .chartYAxis {
                AxisMarks { mark in
                    AxisValueLabel()
                    AxisGridLine()
                }
            }
          //  .chartYScale(domain:) // Größe der Y-Achse ändern
            .chartPlotStyle { plotContent in
                plotContent
                    .background(Color.white)
            }
            }
        .padding()
        

        }
}

struct Diagramme_Previews: PreviewProvider {
    static var previews: some View {
        Diagramme()
    }
}

struct ViewMonth: Identifiable {
    let id = UUID()
    let datum: Date
    let nameÜbung: String
    let gewicht: Double
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let komponenten = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: komponenten)!
        
    }
}


func überprüfeEingabe(_ string: String) -> Bool {
        let regex = #"^[0-9]+$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: string)
}

