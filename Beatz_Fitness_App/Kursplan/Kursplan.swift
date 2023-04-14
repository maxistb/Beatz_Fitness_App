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
    
    var body: some View {
        VStack {
            HeaderView()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    Button(action: {
                        self.selectedDayIndex = 0
                    }, label: {
                        Text("Mo")
                            .font(.headline)
                            .foregroundColor(selectedDayIndex == 0 ? .white : .gray)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(selectedDayIndex == 0 ? Color.blue : Color.clear)
                            .cornerRadius(20)
                    })
                    Button(action: {
                        self.selectedDayIndex = 1
                    }, label: {
                        Text("Di")
                            .font(.headline)
                            .foregroundColor(selectedDayIndex == 1 ? .white : .gray)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(selectedDayIndex == 1 ? Color.blue : Color.clear)
                            .cornerRadius(20)
                    })
                    Button(action: {
                        self.selectedDayIndex = 2
                    }, label: {
                        Text("Mi")
                            .font(.headline)
                            .foregroundColor(selectedDayIndex == 2 ? .white : .gray)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(selectedDayIndex == 2 ? Color.blue : Color.clear)
                            .cornerRadius(20)
                    })
                    Button(action: {
                        self.selectedDayIndex = 3
                    }, label: {
                        Text("Do")
                            .font(.headline)
                            .foregroundColor(selectedDayIndex == 3 ? .white : .gray)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(selectedDayIndex == 3 ? Color.blue : Color.clear)
                            .cornerRadius(20)
                    })
                    Button(action: {
                        self.selectedDayIndex = 4
                    }, label: {
                        Text("Fr")
                            .font(.headline)
                            .foregroundColor(selectedDayIndex == 4 ? .white : .gray)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(selectedDayIndex == 4 ? Color.blue : Color.clear)
                            .cornerRadius(20)
                    })
                }
                .padding(.horizontal, 10)
                
            }
            
            
            VStack(alignment: .leading) {
                if selectedDayIndex == 0 {
                    Text("Kurse für Montag")
                        .font(.headline)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                }
                if selectedDayIndex == 1 {
                    Text("Kurse für Dienstag")
                        .font(.headline)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                }
                if selectedDayIndex == 2 {
                    Text("Kurse für Mittwoch")
                        .font(.headline)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                }
                if selectedDayIndex == 3 {
                    Text("Kurse für Donnerstag")
                        .font(.headline)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                }
                if selectedDayIndex == 4 {
                    Text("Kurse für Freitag")
                        .font(.headline)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                }
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
                            if value.translation.width < 0, selectedDayIndex < 4 {
                                selectedDayIndex += 1
                            } else if value.translation.width > 0, selectedDayIndex > 0 {
                                selectedDayIndex -= 1
                            }
                        }
                )
                
            }
            .animation(.timingCurve(0.2, 0.2, 0.2, 0.2))
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
    
    func HeaderView() -> some View {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateFormat = "EEEE, d MMM"
        
        return HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(dateFormatter.string(from: Date()))
                    .foregroundColor(.gray)
                
                Text("Heute")
                    .font(.largeTitle.bold())
            }
            Spacer()
        }
        .padding()
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




