//
//  Kursplan.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 25.03.23.
//

import SwiftUI

struct Kursplan: View {
    
    @ObservedObject var viewModel = KursplanViewModel()
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<viewModel.days.count, id: \.self) { index in
                        Button(action: {
                            withAnimation(.timingCurve(0.2, 0.2, 0.2, 0.2)) {
                                self.viewModel.selectedDayIndex = index
                            }
                        }, label: {
                            Text(String(viewModel.days[index].prefix(2)))
                                .font(.headline)
                                .foregroundColor(viewModel.selectedDayIndex == index ? .white : .gray)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(viewModel.selectedDayIndex == index ? Color.blue : Color.clear)
                                .cornerRadius(20)
                        })
                    }
                }
                .padding(.horizontal, 10)
            }
            .navigationTitle("Kursplan")
            
            VStack(alignment: .leading) {
                Text(viewModel.courseTitles[viewModel.selectedDayIndex])
                    .font(.headline)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                
                List {
                    ForEach(viewModel.getKurseForSelectedDay()) { kurs in
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
                                if value.translation.width < 0, viewModel.selectedDayIndex < 4 {
                                    viewModel.selectedDayIndex += 1
                                } else if value.translation.width > 0, viewModel.selectedDayIndex > 0 {
                                    viewModel.selectedDayIndex -= 1
                                }
                            }
                        }
                )
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
