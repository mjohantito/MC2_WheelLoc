//
//  FacilityCardView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 30/06/23.
//

import SwiftUI

struct FacilityCardView: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                HStack {
                    Image("elevator")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .leading)
                    .foregroundColor(Color.black)
                    Text("Lift")
                }
                .padding()
                .frame(alignment: .leading)

                HStack{
                    Text("•")
                    Text("Lantai UG - Depan Hypermart")
                }.padding(.bottom,8)
                Spacer()
            }
            .padding()
            .frame(width: 350, alignment: .leading)
            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
            .cornerRadius(10)
            
            
        }
        
    }
}

struct FacilityCardView_Previews: PreviewProvider {
    static var previews: some View {
        FacilityCardView()
    }
}
