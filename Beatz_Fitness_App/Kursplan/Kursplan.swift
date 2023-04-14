//
//  Kursplan.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 25.03.23.
//

import SwiftUI

struct Kursplan: View {
    @State var selectedDayIndex = 0 // initialer Index für Montag
    let days = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag"]
    let courseTitles = [
           "Kurse für Montag",
           "Kurse für Dienstag",
           "Kurse für Mittwoch",
           "Kurse für Donnerstag",
           "Kurse für Freitag"
       ]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<days.count, id: \.self) { index in
                        Button(action: {
                            withAnimation(.timingCurve(0.2, 0.2, 0.2, 0.2)) {
                                self.selectedDayIndex = index
                            }
                        }, label: {
                            Text(String(days[index].prefix(2)))
                                .font(.headline)
                                .foregroundColor(selectedDayIndex == index ? .white : .gray)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(selectedDayIndex == index ? Color.blue : Color.clear)
                                .cornerRadius(20)
                        })
                    }
                }
                .padding(.horizontal, 10)
                .navigationTitle("Kursplan")
            }
        
            VStack(alignment: .leading) {
                            Text(courseTitles[selectedDayIndex])
                                .font(.headline)
                                .padding(.horizontal, 20)
                                .padding(.top, 10)

                List {
                    ForEach(getKurseForSelectedDay()) { kurs in
                        VStack(alignment: .leading) {
                            Text("\(kurs.kursname) \(kurs.kursmacher)")
                                .font(.headline)
                            HStack {
                                Text("\(kurs.kurszeit)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            withAnimation(.timingCurve(0.2, 0.2, 0.2, 0.2)) {
                                if value.translation.width < 0, selectedDayIndex < 4 {
                                    selectedDayIndex += 1
                                } else if value.translation.width > 0, selectedDayIndex > 0 {
                                    selectedDayIndex -= 1
                                }
                            }
                        }
                )
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func getWeekdayName(index: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateFormat = "EEEEEE"
        return dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: index, to: Date())!)
    }
    
    func getKurseForSelectedDay() -> [Kurs] {
        switch selectedDayIndex {
        case 0:
            return kurseMontag
        case 1:
            return kurseDienstag
        case 2:
            return kurseMittwoch
        case 3:
            return kursDonnerstag
        case 4:
            return kurseFreitag
        default:
            return []
        }
    }
}

struct Kursplan_Preview: PreviewProvider {
    static var previews: some View{
        Kursplan()
    }
}




