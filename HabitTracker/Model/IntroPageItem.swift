//
//  IntroPageItem.swift
//  HabitTracker
//
//  Created by Arnaldo Baumanis on 9/25/25.
//

import SwiftUI

struct IntroPageItem: Identifiable {
    var id: String = UUID().uuidString
    var image: String
    var title: String
    
    var scale: CGFloat = 1
    var anchor: UnitPoint = .center
    var offset: CGFloat = 0
    var rotation: CGFloat = 0
    var zindex: CGFloat = 0
    var extraOffset: CGFloat = -350
    var description: String
}

let staticIntroItems: [IntroPageItem] = [
    .init(image: "figure.disc.sports",
          title: "Track your daily\nhabits",
          scale: 1,
          description: "Log your habits daily to stay\non track with your personal growth"
         ),
    .init(image: "pencil.circle.fill",
          title: "Set and track your\nhabits",
          scale: 0.6,
          anchor: .topLeading,
          offset: -70,
          rotation: 30,
          description: "Create and track your habits\nwith ease. You can also set reminders"
         ),
    .init(image: "star.fill",
          title: "Celebrate your\nachievements",
          scale: 0.5,
          anchor: .bottomLeading,
          offset: -60,
          rotation: 35,
          description: "Form habits that stick with\ntime. Celebrate your progress with\nstars and more"
          ),
    .init(image: "book.fill",
          title: "Read more about\nhabits",
          scale: 0.4,
          anchor: .bottomLeading,
          offset: -50,
          rotation: 160,
          extraOffset: -120,
          description: "Celebrate milestones to stay\nmotivated",
          ),
    .init(image: "calendar.circle.fill",
          title: "Track your time\nand progress",
          scale: 0.35,
          anchor: .bottomLeading,
          offset: -50,
          rotation: 250,
          extraOffset: -100,
          description: "Celebrate milestones to stay\nmotivated",
          ),
]
