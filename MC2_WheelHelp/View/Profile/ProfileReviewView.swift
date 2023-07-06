//
//  ProfileReviewView.swift
//  MC2_WheelHelp
//
//  Created by Manuel Johan Tito on 06/07/23.
//

import SwiftUI

struct ProfileReviewView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                ForEach (0..<3, id: \.self){_ in
                    ProfileReviewCardView(userNameReview: "Angelo Kusuma", dateReview: "30 Mar 2023", ratingReview: 4.5, titleReview: "Bagus Banget!", descriptionReview: "Disini fasilitas buat pengguna kursi roda aman banget, bahkan toiletnya disediain khusus buat disabilitas!")
                }

                Spacer()
            }.padding(.top,16)
        }
        .navigationTitle("Ulasan")
        
    }
}

struct ProfileReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileReviewView()
    }
}
