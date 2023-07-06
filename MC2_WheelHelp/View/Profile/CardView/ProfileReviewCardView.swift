//
//  ProfileReviewCardView.swift
//  MC2_WheelHelp
//
//  Created by Manuel Johan Tito on 06/07/23.
//

import SwiftUI

struct ProfileReviewCardView: View {
    
    
    @State public var userNameReview: String
    @State public var dateReview: String
    @State public var ratingReview: Double
    @State public var titleReview: String
    @State public var descriptionReview: String
    
    
    
    
    init(userNameReview: String, dateReview: String, ratingReview: Double, titleReview: String, descriptionReview: String) {
        self._userNameReview = State(initialValue: userNameReview)
        self._dateReview = State(initialValue: dateReview)
        self._ratingReview = State(initialValue: ratingReview)
        self._titleReview = State(initialValue: titleReview)
        self._descriptionReview = State(initialValue: descriptionReview)
        
    }
    
    
    var body: some View {
        HStack{

            VStack(alignment: .leading){
                
                Text(titleReview)
                    .fontWeight(.semibold)
                    .padding(.bottom, 1)
                HStack {
                    
                    ForEach (1..<6) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.yellow)
                    }
    
                    Text("5.0")
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .frame(alignment: .leading)
                .padding(.bottom, 20)
                Text(descriptionReview)
                    .padding(.bottom,8)
                    .font(.system(size: 12))
                
                
            }

        }
        .padding()
        .frame(width: 350, height: 200)
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
        .cornerRadius(10)
    }
}

struct ProfileReviewCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileReviewCardView(userNameReview: "Angelo Kusuma", dateReview: "30 Mar 2023", ratingReview: 4.5, titleReview: "Bagus Banget!", descriptionReview: "Disini fasilitas buat pengguna kursi roda aman banget, bahkan toiletnya disediain khusus buat disabilitas!")
    }
}
