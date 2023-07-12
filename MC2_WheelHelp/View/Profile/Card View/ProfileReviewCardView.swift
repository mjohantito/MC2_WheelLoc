//
//  ProfileReviewCardView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 04/07/23.
//

import SwiftUI

struct ProfileReviewCardView: View {
    
    let userNameReview: String
    let dateReview: String
    let ratingReview: Double
    let titleReview: String
    let descriptionReview: String
    
    var body: some View {
        HStack{

            VStack(alignment: .leading){
                
                
                //Section Title & Rating
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
                .padding(.bottom, 2)
                
                
                
                //Section Description
                Text(descriptionReview)
//                    .padding(.bottom,20)
                    .font(.system(size: 12))
                    .frame(maxHeight: .infinity)
                    
                //Section Image
                HStack{
                    Image("national-hospital")
                        .resizable()
                        .frame(width: 80, height: 50)
                        .cornerRadius(5)
                    
                    
                    Image("national-hospital")
                        .resizable()
                        .frame(width: 80, height: 50)
                        .cornerRadius(5)
                    
                    Image("national-hospital")
                        .resizable()
                        .frame(width: 80, height: 50)
                        .cornerRadius(5)
                }.padding(.bottom,8)
                
                HStack{
                    Text("Pakuwon Mall")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .frame(maxWidth:.infinity, alignment: .leading)
                    HStack{
                        Image(systemName: "hand.thumbsup.fill")
                            .foregroundColor(Color.blue)
                        Text("12")
                        
                    }
                }
                
                
                
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
