//
//  ReviewCardView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 30/06/23.
//

import SwiftUI

struct ReviewCardView: View {
    
    let userNameReview: String
    let dateReview: String
    let ratingReview: Double
    let titleReview: String
    let descriptionReview: String
    
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

struct ReviewCardView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCardView(userNameReview: "Angelo Kusuma", dateReview: "30 Mar 2023", ratingReview: 4.5, titleReview: "Bagus Banget!", descriptionReview: "Disini fasilitas buat pengguna kursi roda aman banget, bahkan toiletnya disediain khusus buat disabilitas!")
    }
}
