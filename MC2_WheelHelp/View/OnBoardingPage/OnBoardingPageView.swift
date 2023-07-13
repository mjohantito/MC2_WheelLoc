//
//  OnBoardingPageView.swift
//  MC2_WheelHelp
//
//  Created by Angelo Kusuma on 30/06/23.
//

import SwiftUI
import UIKit

struct OnBoardingPageView: View {
    
    private let onBoardingPage = [
        OnBoarding(image: "OnBoardingPage1", background: "Blurry 1", title: "Selamat Datang!", description: "Wheeloc menyediakan informasi yang anda butuhkan ketika bepergian dengan pengguna kursi roda"),
        OnBoarding(image: "OnBoardingPage2", background: "Blurry 1", title: "Pergi ke Tempat Baru Tanpa Ragu", description: ""),
        OnBoarding(image: "OnBoardingPage3", background: "Blurry 2", title: "Rekomendasi Fasilitas Medis Terdekat", description: ""),
        OnBoarding(image: "OnBoardingPage4", background: "Blurry 2", title: "Bagikan Pengalaman Anda Melalui Ulasan", description: "")
    ]
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(red: 64/255, green: 190/255, blue: 218/255, alpha: 100)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    var body: some View {
        TabView {
            ForEach(0..<onBoardingPage.count) { x in
                ZStack {
                    Image(onBoardingPage[x].image)
                        .resizable()
                        .scaledToFill()
                    
                    VStack(alignment: .center){
                        Text(onBoardingPage[x].title)
                            .padding(10)
                            .multilineTextAlignment(.center)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color(red: 19/255, green: 70/255, blue: 97/255))
                        
                        Text(onBoardingPage[x].description)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        if(x == 3){
                            Text("Lanjut ke Aplikasi")
                                .padding(16)
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 37/255, green: 157/255, blue: 184/255))
                                .cornerRadius(10)
                                .padding(.horizontal, 32)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: PlaceView())
                                }
                        }
                    }
                    .padding(.top, 450)
                    
                    VStack {
                        HStack (){
                            Spacer()
                            Text("Skip")
                                .foregroundColor(Color(red: 37/255, green: 157/255, blue: 184/255))
                                .onTapGesture {
                                    UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: PlaceView())
                                }
                                .padding(.top,50)
                                .padding(.trailing,40)
                        }
                        Spacer()
                    }
                }
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(.page)
    }
}

struct OnBoardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPageView()
    }
}
