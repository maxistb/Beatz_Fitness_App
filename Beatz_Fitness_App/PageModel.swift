//
//  PageModel.swift
//  SlidingIntroScreen
//
//  Created by Federico on 18/03/2022.
//

import Foundation

struct Page: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var imageUrl: String
    var tag: Int
    
    static var samplePage = Page(name: "Title Example", description: "This is a sample description for the purpose of debugging", imageUrl: "work", tag: 0)
    
    static var samplePages: [Page] = [
        Page(name: "Willkommen zur BEATZ Fitness App!", description: "Die App für dein lokales Fitnessstudio.", imageUrl: "cowork", tag: 0),
        Page(name: "Optimiere dein Training!", description: "Durch vordefinierte Splits und empfohlene Trainingspläne kannst du deine Fortschritte maximieren.", imageUrl: "work", tag: 1),
        Page(name: "Schaue dir deine Fortschritte an!", description: "Durch Diagramme kannst du dir stets deine Fortschritte live ansehen.", imageUrl: "website", tag: 2),
    ]
}
