//
//  ContentView.swift
//  ScreenshotAnimation
//
//  Created by suxiangnan on 2024/10/10.
//

import SwiftUI

struct TargetView: View {
    @Binding var isShow: Bool
    @Binding var isSlideHide: Bool

    var body: some View {
        VStack {
            Spacer()
                .frame(height: 30.0)

            HStack {
                Spacer()

                Text("Shot Image")
                    .font(.system(size: 30, weight: .bold, design: .serif).italic())
                    .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.2)
                    .background(Color.yellow.opacity(isShow ? 1.0 : 0.0))
                    .clipShape(.rect(cornerRadius: 16.0, style: .continuous))
                    .scaleEffect(isShow ? 1.0 : 0.6, anchor: .center)
                    .offset(x: isSlideHide ? 400 : .zero)

                Spacer()
                    .frame(width: 45.0)
            }

            Spacer()
        }
    }
}

struct ContentView: View {
    @State var isShot: Bool = false
    @State var isKeepScale: Bool = false
    @State var isShow: Bool = false
    @State var isSlideHide: Bool = false

    var body: some View {
        ZStack {
            Text("Cover View")
                .font(.system(size: 30, weight: .bold, design: .serif).italic())
                .offset(x: 100, y: 100)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white.opacity(isShot ? 0.9 : .zero))
                .clipShape(.rect(cornerRadius: 60.0, style: .continuous))
                .scaleEffect(isKeepScale ? 0.25 : 1.0, anchor: UnitPoint(x: 0.975, y: 0.03))

            TargetView(isShow: $isShow, isSlideHide: $isSlideHide)

            Button {
                guard !isKeepScale else { return }

                withAnimation(.spring(duration: 0.5, bounce: 0.1)) {
                    isShot = true
                    isKeepScale = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isShot = false
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isKeepScale = false
                    }
                }

                guard !isShow else { return }

                withAnimation(.spring(duration: 0.5, bounce: 0.1).delay(0.2)) {
                    isShow = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7 + 1) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isSlideHide = true
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isShow = false
                        isSlideHide = false
                    }
                }

            } label: {
                Text("Shot Shot Shot")
                    .font(.system(size: 30, weight: .bold, design: .serif).italic())
                    .foregroundStyle(Color.black)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ZStack {
        ContentView()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.mint)
}
