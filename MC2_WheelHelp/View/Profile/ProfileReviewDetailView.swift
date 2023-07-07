//
//  ProfileReviewDetailView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 04/07/23.
//

import SwiftUI

struct ProfileReviewDetailView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading){
                    Text("Bagus Banget!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top,10)
                        .padding(.bottom,8)
                    
                    HStack {
                        
                        ForEach (1..<6) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.yellow)
                        }
                        Spacer()
                        
                        Text("30 Mar 2023")
                            .font(.system(size: 14))
                            .foregroundColor(Color.gray)
                        
    
                    }
                    .frame(alignment: .leading)
                    .padding(.bottom,12)
                    
                    VStack{
                        Text("Disini fasilitas buat pengguna kursi roda aman banget, bahkan toiletnya disediain khusus buat disabilitas!")
                    }
                    
                    HStack{
                        
                        Image("national-hospital")
                            .resizable()
                            .frame(width: 180, height: 120)
                            .cornerRadius(10)
                        
                        
                        Image("national-hospital")
                            .resizable()
                            .frame(width: 180, height: 120)
                            .cornerRadius(10)
                        
                       
                    }.padding(.bottom,20)
                    
                    
                    Text("Fasilitas")
                        .fontWeight(.bold)
                        .foregroundColor(Color.mint)
                    VStack{
                        ScrollView{
                            
                        }
                        ForEach (0..<3, id: \.self){_ in
                            FacilityCardView()
                        }
                        
                    }
                }
                .padding()
                
            }
            
        }
    }
}

struct ProfileReviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileReviewDetailView()
    }
}
