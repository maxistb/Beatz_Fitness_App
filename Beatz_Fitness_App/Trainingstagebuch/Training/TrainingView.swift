//
//  TrainingstagebuchÜbungen.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 10.04.23.
//

import SwiftUI
import Introspect

struct TrainingView: View {
	@StateObject var viewModel: TrainingViewModel
	@State private var showingAlert = false
	@Environment(\.presentationMode) var presentationMode
	@State private var isEditing = false
	@FocusState var isInputActive: Bool
		
	
	var body: some View {
		VStack {
			let previousWeights = viewModel.getPreviousTrainingWeights()
			List {
				ForEach(viewModel.selectedSplit.getUebungen.indices, id: \.self) { uebungIndex in
					var uebung = viewModel.selectedSplit.getUebungen[uebungIndex]
					Section(header: Text(uebung.name ?? "")) {
						ForEach(0..<Int(uebung.saetze), id: \.self) { saetzeIndex in
							HStack {
								if viewModel.isAufwärmsatz[uebungIndex][saetzeIndex] {
									Section(header: Text("Aufwärm.").font(Font.system(size: 16, weight: .regular))) {
										viewModel.gewichtTextField(value: Binding(
											get: { viewModel.gewichte[uebungIndex][saetzeIndex] },
											set: { newValue in
												viewModel.gewichte[uebungIndex][saetzeIndex] = newValue
											}
										))
										.introspectTextField { (textField) in
											let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
											let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
											let doneButton = UIBarButtonItem(title: "Fertig", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
											doneButton.tintColor = UIColor.init(Color(red: 0/255, green: 166/255, blue: 205/255))
											toolBar.items = [flexButton, doneButton]
											toolBar.setItems([flexButton, doneButton], animated: true)
											textField.inputAccessoryView = toolBar
										}
										.onAppear {
											if uebungIndex < previousWeights.count && saetzeIndex < previousWeights[uebungIndex].count {
												let previousWeight = previousWeights[uebungIndex][saetzeIndex]
												viewModel.gewichte[uebungIndex][saetzeIndex] = previousWeight
											}
										}
									}
								} else if viewModel.isDropsatz[uebungIndex][saetzeIndex] {
									Section(header: Text("Dropsatz").font(Font.system(size: 16, weight: .regular))) {
										viewModel.gewichtTextField(value: Binding(
											get: { viewModel.gewichte[uebungIndex][saetzeIndex] },
											set: { newValue in
												viewModel.gewichte[uebungIndex][saetzeIndex] = newValue
											}
										))
										.introspectTextField { (textField) in
											let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
											let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
											let doneButton = UIBarButtonItem(title: "Fertig", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
											doneButton.tintColor = UIColor.init(Color(red: 0/255, green: 166/255, blue: 205/255))
											toolBar.items = [flexButton, doneButton]
											toolBar.setItems([flexButton, doneButton], animated: true)
											textField.inputAccessoryView = toolBar
										}
										.onAppear {
											if uebungIndex < previousWeights.count && saetzeIndex < previousWeights[uebungIndex].count {
												let previousWeight = previousWeights[uebungIndex][saetzeIndex]
												viewModel.gewichte[uebungIndex][saetzeIndex] = previousWeight
											}
										}
									}
								} else {
									viewModel.gewichtTextField(value: Binding(
										get: { viewModel.gewichte[uebungIndex][saetzeIndex] },
										set: { newValue in
											viewModel.gewichte[uebungIndex][saetzeIndex] = newValue
										}
									))
									.introspectTextField { (textField) in
										let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
										let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
										let doneButton = UIBarButtonItem(title: "Fertig", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
										doneButton.tintColor = UIColor.init(Color(red: 0/255, green: 166/255, blue: 205/255))
										toolBar.items = [flexButton, doneButton]
										toolBar.setItems([flexButton, doneButton], animated: true)
										textField.inputAccessoryView = toolBar
									}
									.onAppear {
										if uebungIndex < previousWeights.count && saetzeIndex < previousWeights[uebungIndex].count {
											let previousWeight = previousWeights[uebungIndex][saetzeIndex]
											viewModel.gewichte[uebungIndex][saetzeIndex] = previousWeight
										}
									}
								}
								viewModel.wiederholungenTextField(value: $viewModel.wiederholungen[uebungIndex][saetzeIndex])
									.introspectTextField { (textField) in
										let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
										let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
										let doneButton = UIBarButtonItem(title: "Fertig", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
										doneButton.tintColor = UIColor.init(Color(red: 0/255, green: 166/255, blue: 205/255))
										toolBar.items = [flexButton, doneButton]
										toolBar.setItems([flexButton, doneButton], animated: true)
										textField.inputAccessoryView = toolBar
									}
								
								if viewModel.isAufwärmsatz[uebungIndex][saetzeIndex] {
									Menu("\(Image(systemName: "ellipsis"))") {
										Button("Satz") {
											viewModel.isDropsatz[uebungIndex][saetzeIndex] = false
											viewModel.isAufwärmsatz[uebungIndex][saetzeIndex] = false
										}
										
										Button("Dropsatz") {
											viewModel.isAufwärmsatz[uebungIndex][saetzeIndex] = false
											viewModel.isDropsatz[uebungIndex][saetzeIndex] = true
										}
									}
									.foregroundColor(Color(red: 0/255, green: 166/255, blue: 205/255))
								} else if viewModel.isDropsatz[uebungIndex][saetzeIndex] {
									Menu("\(Image(systemName: "ellipsis"))") {
										Button("Satz") {
											viewModel.isDropsatz[uebungIndex][saetzeIndex] = false
											viewModel.isAufwärmsatz[uebungIndex][saetzeIndex] = false
										}
										
										Button("Aufwärmsatz") {
											viewModel.isAufwärmsatz[uebungIndex][saetzeIndex] = true
											viewModel.isDropsatz[uebungIndex][saetzeIndex] = false
										}
									}
									.foregroundColor(Color(red: 0/255, green: 166/255, blue: 205/255))
								} else {
									Menu("\(Image(systemName: "ellipsis"))") {
										Button("Aufwärmsatz") {
											viewModel.isDropsatz[uebungIndex][saetzeIndex] = false
											viewModel.isAufwärmsatz[uebungIndex][saetzeIndex] = true
										}
										
										Button("Dropsatz") {
											viewModel.isAufwärmsatz[uebungIndex][saetzeIndex] = false
											viewModel.isDropsatz[uebungIndex][saetzeIndex] = true
										}
									}
									.foregroundColor(Color(red: 0/255, green: 166/255, blue: 205/255))
								}
							}
							
							.swipeActions {
								Button(action: {
									withAnimation {
										uebung.saetze -= 1
										viewModel.gewichte[uebungIndex].remove(at: saetzeIndex)
										viewModel.wiederholungen[uebungIndex].remove(at: saetzeIndex)
										viewModel.isAufwärmsatz[uebungIndex].remove(at: saetzeIndex)
										viewModel.isDropsatz[uebungIndex].remove(at: saetzeIndex)
									}
								}) {
									Image(systemName: "trash")
								}
								.tint(.red)
							}
						}
						Section {
							Button(action: {
								withAnimation {
									uebung.saetze += 1
									viewModel.isAufwärmsatz[uebungIndex].append(false)
									viewModel.isDropsatz[uebungIndex].append(false)
									viewModel.gewichte[uebungIndex].append("")
									viewModel.wiederholungen[uebungIndex].append("")
									uebung = viewModel.selectedSplit.getUebungen[uebungIndex]
								}
							}) {
								Text("Hinzufügen")
									.foregroundColor(Color(red: 0/255, green: 166/255, blue: 205/255))
							}
						}
					}
					
				}
				
				Section(header: Text("Notizen")) {
					TextField("", text: $viewModel.notizenTraining, axis: .vertical)
						.focused($isInputActive)
						.toolbar {
							ToolbarItemGroup(placement: .keyboard) {
								Spacer()
								Button("Fertig") {
									isInputActive = false
								}
							}
						}
				}
				
				Section {
					viewModel.createButton(showingAlert: $showingAlert)
				}
				.listRowBackground(Color.clear)
				.listStyle(InsetGroupedListStyle())
				
			}
			.navigationBarTitle(viewModel.selectedSplit.name ?? "")
			.alert(isPresented: $showingAlert) {
				Alert(
					title: Text("Training abgeschlossen"),
					message: Text("Das Training wurde erfolgreich gespeichert."),
					dismissButton: .default(
						Text("OK"),
						action: {
							presentationMode.wrappedValue.dismiss()
						}
					)
				)
			}
		}
	}
}

