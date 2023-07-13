//
//  LikeButtonView.swift
//  MC2_WheelHelp
//
//  Created by Dyah Putri Nariswari on 06/07/23.
//

import SwiftUI
import CloudKit

struct LikeButtonView: View {
    @State public var likesCount: Int64
    @State public var isLiked: Bool
    @State public var ckRecordIdReview: CKRecord.ID
//    @State public var userId: String
    
    @AppStorage("userIdGlobal") var userIdGlobal: String = ""
    
    var body: some View {
        
        HStack {
            // thumbs up button
            let a = print("IS LIKED ON VIEW: \(isLiked)")
            Button(action: {
                if isLiked {
                    likesCount -= 1
                } else {
                    likesCount += 1
                }
                isLiked.toggle()
                
                updateReviewLikes(ckRecordIdReview: ckRecordIdReview, currentLikes: Int64(likesCount))
                addLikeToCloudkit(userId: userIdGlobal, reviewId: CKRecord.Reference(recordID: ckRecordIdReview, action:.none))
                
            }) {
                Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                    .resizable()
                    .frame(width: 18, height: 18)
            }
            .foregroundColor(isLiked ? Color("customSecondary") : .gray)
            .frame(width: 18, height: 30)
            
            // likes count
            Text("\(likesCount)")
                .frame(width: 30, height: 30)
                .padding(.horizontal, -4)
            
        }
        
    }
}


struct LikeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LikeButtonView(likesCount: 0, isLiked: false, ckRecordIdReview: CKRecord.ID(recordName: "3D204835-A7D5-4F80-8A7F-632C2CB1FBA8")/*, userId: "default"*/)
    }
}
