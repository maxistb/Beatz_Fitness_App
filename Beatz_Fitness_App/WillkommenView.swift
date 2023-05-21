//
//  ContentView.swift
//  SlidingIntroScreen
//
//  Created by Federico on 18/03/2022.
//

import SwiftUI

struct WillkommenView: View {
    @State private var pageIndex = 0
    private let pages: [Page] = Page.samplePages
    @State private var isSignUpComplete = false
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
           TabView(selection: $pageIndex) {
               ForEach(pages) { page in
                   VStack {
                       Spacer()
                       PageView(page: page)
                       Spacer()
                       
                       if page == pages.last {
                           Button("Fertig!", action: completeSignUp)
                               .buttonStyle(.bordered)
                       } else {
                           Button("Weiter", action: incrementPage)
                               .buttonStyle(.borderedProminent)
                       }
                       
                       Spacer()
                   }
                   .tag(page.tag)
               }
           }
           .animation(.easeInOut, value: pageIndex)
           .indexViewStyle(.page(backgroundDisplayMode: .interactive))
           .tabViewStyle(PageTabViewStyle())
           .onAppear {
               dotAppearance.currentPageIndicatorTintColor = .black
               dotAppearance.pageIndicatorTintColor = .gray
           }
           .fullScreenCover(isPresented: $isSignUpComplete, content: {
               Hauptbildschirm()
           })
       }
       
       func incrementPage() {
           pageIndex += 1
       }
       
       func completeSignUp() {
           isSignUpComplete = true
       }
   }
struct WillkommenView_Preview: PreviewProvider {
    static var previews: some View {
        WillkommenView()
    }
}
