//
//  TrainingseintragDetailVM.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 13.05.23.
//

import SwiftUI

extension TrainingseintragDetailView {
    func alertTF(title: String, message: String, gewichtText: String, wiederholungenText: String, primaryTitle: String, secondaryTitle: String, primaryAction: @escaping (String, String)->(), secondaryAction: @escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField {field in
            field.placeholder = gewichtText
            field.keyboardType = .decimalPad
        }
        alert.addTextField {field in
            field.placeholder = wiederholungenText
            field.keyboardType = .numberPad
        }
        
        alert.addAction(.init(title: secondaryTitle, style: .cancel, handler: { _ in
            secondaryAction()
        }))
        
        alert.addAction(.init(title: primaryTitle, style: .default, handler: { _ in
            if let gewicht = alert.textFields?[0].text?.replacingOccurrences(of: ",", with: "."), let wiederholungen = alert.textFields?[1].text {
                primaryAction(gewicht, wiederholungen)
            }
            else {
                primaryAction("", "")
            }
        }))
        rootController().present(alert, animated: true, completion: nil)
    }
    
    func rootController()-> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }

        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }

        return root
    }
    
    
    func isValidInput(input: String) -> Bool {
        if Int(input) != nil {
            return true
        } else if Double(input) != nil {
            return true
        } else {
            return false
        }
    }
    func delete(ausgefuehrterSatz: AusgefuehrterSatz) {
        trainingseintrag.removeFromAusgefuehrteUebungen(ausgefuehrterSatz)
        try? moc.save()
    }
    
    func move(from source: IndexSet, to destination: Int) {
         var indices = Array(source)
         indices.sort()
         for (i, index) in indices.enumerated() {
             if index < destination {
                 trainingseinträge[destination - indices.count + i].split.order = Int64(index)
             } else {
                 trainingseinträge[destination + i].split.order = Int64(index + indices.count)
             }
         }
         try? moc.save()
     }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    let locale = Locale(identifier: "de_DE")
    formatter.locale = locale
    return formatter
}()
