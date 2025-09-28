//
//  IntroPageView.swift
//  HabitTracker
//
//  Created by Arnaldo Baumanis on 9/25/25.
//

import SwiftUI

struct IntroPageView: View {
    @State private var selectedItem: IntroPageItem = staticIntroItems.first!
    @State private var introItems: [IntroPageItem] = staticIntroItems
    @State private var activeIndex: Int = 0
    @State private var askUsername: Bool = false
    
    @AppStorage("username") private var username: String = ""
    @AppStorage("isIntroComplete") private var isIntroComplete: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Button {
                updateItem(isForward: false)
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3.bold())
                    .foregroundStyle(.myColors.gradient)
                    .contentShape(.rect)
            }
            .padding(15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(selectedItem.id != introItems.first?.id ? 1 : 0)
            
            ZStack {
                ForEach(introItems) { item in
                    AnimatedIconView(item)
                }
            }
            .frame(height: 250)
            .frame(maxWidth: .infinity)
            
            VStack(spacing: 6) {
                HStack(spacing: 4) {
                    ForEach(introItems) { item in
                        Capsule()
                            .fill((selectedItem.id == item.id ? Color(.myColors) : .gray).gradient)
                            .frame(width: selectedItem.id == item.id ? 25 : 4, height: 4)
                    }
                }
                .padding(.bottom, 15)
                
                Text(selectedItem.title)
                    .font(.title.bold())
                    .contentTransition(.numericText())
                
                Text(selectedItem.description)
                    .contentTransition(.numericText())
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                Button {
                    if selectedItem.id == introItems.last?.id { askUsername.toggle() }
                    updateItem(isForward: true)
                } label: {
                    Text(selectedItem.id == introItems.last?.id ? "Got it!" : "Next")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .contentTransition(.numericText())
                        .frame(width: 250)
                        .padding(.vertical, 12)
                        .background(.myColors.gradient, in: .rect(cornerRadius: 10))
                }
                .padding(.top, 25)
            }
            .multilineTextAlignment(.center)
            .frame(width: 300)
            .frame(maxHeight: .infinity)
        }
        .ignoresSafeArea(.keyboard, edges: .all)
        .overlay() {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(.gray.opacity(askUsername ? 0.3 : 0))
                    .ignoresSafeArea()
                    .onTapGesture {
                        askUsername = false
                    }
                
                if askUsername {
                    UserNameView()
                        .transition(.move(edge: .bottom).combined(with: .offset(y: 100)))
                }
            }
            .animation(.snappy, value: askUsername)
        }
    }
    
    @ViewBuilder
    func AnimatedIconView(_ item: IntroPageItem) -> some View {
        let isSelected = selectedItem.id == item.id
        
        Image(systemName: item.image)
            .font(.system(size: 80))
            .foregroundStyle(.white.shadow(.drop(radius: 10)))
            .blendMode(.overlay)
            .frame(width: 120, height: 120)
            .background(.myColors.gradient, in: .rect(cornerRadius: 32))
            .background {
                RoundedRectangle(cornerRadius: 35)
                    .fill(.background)
                    .shadow(color: .primary.opacity(0.2), radius: 1, x: 1, y: 1)
                    .shadow(color: .primary.opacity(0.2), radius: 1, x: -1, y: -1)
                    .padding(-3)
                    .opacity(selectedItem.id == item.id ? 1 : 0)
            }
            .rotationEffect(.init(degrees: -item.rotation))
            .scaleEffect(isSelected ? 1.1 : item.scale, anchor: item.anchor)
            .offset(x: item.offset)
            .rotationEffect(.init(degrees: item.rotation))
            .zIndex(isSelected ? 2 : item.zindex)
    }
    
    @ViewBuilder
    func UserNameView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Let's start with your name")
                .font(.caption)
                .foregroundStyle(.gray)
            
            TextField("Enter your name", text: $username)
                .applyPaddedBackground(10, hPadding: 15, vPadding: 15)
                .opacityShadow(.black, opacity: 0.1, radius: 5)
            
            Button {
                isIntroComplete = true
            } label: {
                Text("Start tracking your habits")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .hSpacing(.center)
                    .padding(.vertical, 12)
                    .background(.myColors.gradient, in: .rect(cornerRadius: 10))
            }
            .disableWithOpacity(username.isEmpty)
            .padding(.top, 10)
        }
        .applyPaddedBackground(12)
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
    
    
    func updateItem(isForward: Bool) {
        guard isForward ? activeIndex != introItems.count - 1 : activeIndex != 0 else { return }
        
        var fromIndex: Int
        var extraOffset: CGFloat
        
        if isForward {
            activeIndex += 1
            fromIndex = activeIndex - 1
            extraOffset = introItems[activeIndex].extraOffset
        } else {
            activeIndex -= 1
            extraOffset = introItems[activeIndex].extraOffset
            fromIndex = activeIndex + 1
        }
        
//        if isForward {
//            fromIndex = activeIndex - 1
//            extraOffset = introItems[activeIndex].extraOffset
//        } else {
//            extraOffset = introItems[activeIndex].extraOffset
//            fromIndex = activeIndex + 1
//        }
        
        for index in introItems.indices {
            introItems[index].zindex = 0
        }
        
        Task { [fromIndex, extraOffset] in
            withAnimation(.bouncy(duration: 2)) {
                introItems[fromIndex].scale = introItems[activeIndex].scale
                introItems[fromIndex].rotation = introItems[activeIndex].rotation
                introItems[fromIndex].anchor = introItems[activeIndex].anchor
                introItems[fromIndex].offset = introItems[activeIndex].offset
                
                introItems[activeIndex].offset = extraOffset
                
                introItems[fromIndex].zindex = 1
            }
            
            try? await Task.sleep(for: .seconds(0.1))
            
            withAnimation(.bouncy(duration: 1)) {
                introItems[activeIndex].scale = 1
                introItems[activeIndex].rotation = .zero
                introItems[activeIndex].anchor = .center
                introItems[activeIndex].offset = .zero
                                
                selectedItem = introItems[activeIndex]
            }
        }
        
    }
}

#Preview {
    IntroPageView()
}
