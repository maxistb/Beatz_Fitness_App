//
//  KursplanViewModel.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 24.04.23.
//

import SwiftUI

class KursplanViewModel: ObservableObject {
    @Published var selectedDayIndex = 0
    @Published var days = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag"]
    @Published var courseTitles = [
        "Kurse für Montag",
        "Kurse für Dienstag",
        "Kurse für Mittwoch",
        "Kurse für Donnerstag",
        "Kurse für Freitag"
    ]
    
    
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
    
    struct Kurs: Identifiable {
        var id = UUID()
        var kursname: String
        var kurszeit: String
        var anmelden: String?
        var kursmacher: String
    }
    
    var kurseMontag = [
        Kurs(kursname: "Functional Fitness", kurszeit: "9 - 10 Uhr", kursmacher: "mit Dome"),
        Kurs(kursname: "Rückenfit", kurszeit: "10 - 11 Uhr", kursmacher: "mit Larissa"),
        Kurs(kursname: "Jumping", kurszeit: "18 - 19 Uhr mit Anmeldung", kursmacher: "mit Birte"),
        Kurs(kursname: "Body Complete", kurszeit: "19 - 20 Uhr", kursmacher: "mit Birte")
    ]
    
    var kurseDienstag = [
        Kurs(kursname: "Yoga", kurszeit: "10 - 11 Uhr", kursmacher: "mit Jelena"),
        Kurs(kursname: "Knock-Out", kurszeit: "18 - 19 Uhr", kursmacher: "mit Larissa"),
        Kurs(kursname: "Bauch, Beine & Po", kurszeit: "19 - 20 Uhr", kursmacher: "mit Larissa")
    ]
    
    var kurseMittwoch = [
        Kurs(kursname: "Mama Kurs", kurszeit: "10 - 11 Uhr ab einer Anmeldung von 10 Personen mit Kind", kursmacher: "mit Larissa"),
        Kurs(kursname: "Zumba", kurszeit: "18 - 19 Uhr", kursmacher: "mit Birte"),
        Kurs(kursname: "Bauch Intensiv", kurszeit: "19 - 19:30 Uhr", kursmacher: "mit Dome")
    ]
    
    var kursDonnerstag = [
        Kurs(kursname: "Zumba", kurszeit: "9:30 - 10:30 Uhr", kursmacher: "mit Birte"),
        Kurs(kursname: "Rückenexpress", kurszeit: "10:30 - 11 Uhr", kursmacher: "mit Birte"),
        Kurs(kursname: "Hit am Cage", kurszeit: "18 - 18:30 Uhr", kursmacher: "mit Larissa"),
        Kurs(kursname: "Yoga", kurszeit: "18 - 19 Uhr", kursmacher: "mit Jelena"),
        Kurs(kursname: "Piloxing", kurszeit: "19 - 20 Uhr", kursmacher: "mit Larissa")
    ]
    
    var kurseFreitag = [
        Kurs(kursname: "Body Complete", kurszeit: "9 - 10 Uhr", kursmacher: "mit Birte"),
        Kurs(kursname: "Functional Fitness", kurszeit: "10 - 11 Uhr", kursmacher: "mit Dome"),
        Kurs(kursname: "Jumping", kurszeit: "18 - 19 Uhr mit Anmeldung", kursmacher: "mit Birte")
    ]
}
