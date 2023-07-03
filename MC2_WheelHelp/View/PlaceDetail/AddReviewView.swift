//
//  AddReviewView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 26/06/23.
//

import SwiftUI
import PhotosUI

struct AddReviewView: View {
    
    @Environment(\.dismiss) var dismissSheet
     @State private var enterName = ""
     @State private var titleReview = ""
     @State private var descriptionReview = ""
     
     //Boolean isOnFasilitasUlasan
     @State private var isOnEscalator = false
     @State private var isOnToiletDisable = false
     @State private var isOnLift = false
     @State private var isOnRamp = false
     @State private var isOnEnterAccess = false
     @State private var isOnParking = false
     @State private var isOnAvailableWheelchair = false
     
     // Input Escalator
     @State private var floorEscalator = ""
     @State private var locationEscalator = ""
     @State private var rowsEscalator: [String] = [""]
     
     // Input Toilet Disabilitas
     @State private var floorToiletDisable = ""
     @State private var locationToiletDisable = ""
     @State private var rowsToilet: [String] = [""]
     
     // Input Lift
     @State private var floorLift = ""
     @State private var locationLift = ""
     @State private var rowsLift: [String] = [""]
     
     // Input Tanjakan
     @State private var floorRamp = ""
     @State private var locationRamp = ""
     @State private var rowsRamp: [String] = [""]
     
     // Input Enter Access
     @State private var floorEnterAccess = ""
     @State private var locationEnterAccess = ""
     @State private var rowsEnterAccess: [String] = [""]
     
     // Input Parkir
     @State private var floorParking = ""
     @State private var locationParking = ""
     @State private var rowsParking: [String] = [""]
     
     // Input WheelChair
     @State private var floorAvailableWheelchair = ""
     @State private var locationAvailableWheelchair = ""
     @State private var rowsWheelChair: [String] = [""]
     
     // Input Image
     @State private var image: Image? = nil
     @State private var selectedItems = [PhotosPickerItem]()
     @State private var selectedImages = [Image]()
     
     @State var rating: CGFloat
     @State var maxRating: Int
     
     @State var selected = -1
     @State var message = false
     
     var body: some View {
         NavigationView{
             
             List{
                 
                 // Section Escalator
                 Group {
                     HStack{
                         Image(systemName: "figure.roll")
                         Toggle("Eskalator", isOn: $isOnEscalator)
                     }
                     
                     //Add Row Lift
                     if (isOnEscalator == true){
                         ForEach(0..<rowsEscalator.count, id: \.self) { index in
                             
                             //Isi form row Lift
                             HStack {
                                 VStack{
                                     HStack{
                                         Text("Lantai")
                                         TextField("Contoh: G", text: $floorEscalator)
                                             .textContentType(.givenName)
                                             .multilineTextAlignment(.leading)
                                         
                                     }
                                     HStack{
                                         Text("Lokasi")
                                         TextField("Depan Toko Bulan", text: $locationEscalator)
                                             .textContentType(.givenName)
                                             .multilineTextAlignment(.leading)
                                     }
                                 }
                                 
                                 //Delete Row Lift
                                 Button(action: {
                                     rowsEscalator.remove(at: index)
                                 }) {
                                     Image(systemName: "minus.circle")
                                         .foregroundColor(.red)
                                 }
                             }
                         }
                         
                         //Add Row Lift
                         Button("Add Row"){
                             rowsEscalator.append("")
                         }
                         
                     }
                     
                 }
                 
                 //Toilet Disabilitas
                 Group {
                     HStack{
                         Image(systemName: "figure.roll")
                         Toggle("Toilet Disabilitas", isOn: $isOnToiletDisable)
                         
                     }
                     
                     //Add Row Toilet Disabilitas
                     
                     if (isOnToiletDisable == true){
                         ForEach(0..<rowsToilet.count, id: \.self) { index in
                             
                             //Isi form row Lift
                             HStack {
                                 VStack{
                                     HStack{
                                         Text("Lantai")
                                         TextField("Contoh: G", text: $floorToiletDisable)
                                             .textContentType(.givenName)
                                             .multilineTextAlignment(.leading)
                                         
                                     }
                                     HStack{
                                         Text("Lokasi")
                                         TextField("Depan Toko Bulan", text: $locationToiletDisable)
                                             .textContentType(.givenName)
                                             .multilineTextAlignment(.leading)
                                     }
                                 }
                                 
                                 //Delete Row Lift
                                 Button(action: {
                                     rowsToilet.remove(at: index)
                                 }) {
                                     Image(systemName: "minus.circle")
                                         .foregroundColor(.red)
                                 }
                             }
                         }
                         
                         //Add Row Lift
                         Button("Add Row"){
                             rowsToilet.append("")
                         }
                         
                     }
//                     if (isOnToiletDisable == true){
//                         ForEach(0..<rowsToilet.count, id: \.self) { index in
//                             HStack {
//                                 TextField("Enter text", text: $rowsToilet[index])
//                                     .textContentType(.givenName)
//                                     .multilineTextAlignment(.leading)
//
//                                 Button(action: {
//                                     rowsToilet.remove(at: index)
//                                 }) {
//                                     Image(systemName: "minus.circle")
//                                         .foregroundColor(.red)
//                                 }
//                             }
//                         }
//
//                         Button("Add Row"){
//                             rowsToilet.append("")
//                         }
//                     }
                 }
                 
                 // Lift Toggle
                 Group {
                     HStack{
                         Image(systemName: "figure.roll")
                         Toggle("Lift", isOn: $isOnLift)
                     }
                     
                     //Add Row Lift
                     if (isOnLift == true){
                         ForEach(0..<rowsLift.count, id: \.self) { index in
                             
                             //Isi form row Lift
                             HStack {
                                 VStack{
                                     HStack{
                                         Text("Lantai")
                                         TextField("Contoh: G", text: $floorLift)
                                             .textContentType(.givenName)
                                             .multilineTextAlignment(.leading)
                                         
                                     }
                                     HStack{
                                         Text("Lokasi")
                                         TextField("Depan Toko Bulan", text: $locationLift)
                                             .textContentType(.givenName)
                                             .multilineTextAlignment(.leading)
                                     }
                                 }
                                 
                                 //Delete Row Lift
                                 Button(action: {
                                     rowsLift.remove(at: index)
                                 }) {
                                     Image(systemName: "minus.circle")
                                         .foregroundColor(.red)
                                 }
                             }
                         }
                         
                         //Add Row Lift
                         Button("Add Row"){
                             rowsLift.append("")
                         }
                         
                     }
                     
                 }
                 
                 
                 //Tanjakan
                 Group{
                     HStack{
                         Image(systemName: "figure.roll")
                         Toggle("Tanjakan", isOn: $isOnRamp)
                     }
                     
                     //Add Row Tanjakan
                     if (isOnRamp == true){
                         
                         //Isi Form row tanjakan
                         ForEach(0..<rowsRamp.count, id: \.self) { index in
                             HStack {
                                 VStack{
                                     HStack{
                                         Text("Lantai")
                                         TextField("Contoh: G", text: $floorRamp)
                                             .textContentType(.givenName)
                                             .multilineTextAlignment(.leading)
                                         
                                     }
                                     HStack{
                                         Text("Lokasi")
                                         TextField("Depan Toko Bulan", text: $locationRamp)
                                             .textContentType(.givenName)
                                             .multilineTextAlignment(.leading)
                                     }
                                 }
                                 
                                 //Delete Row Tanjakan
                                 Button(action: {
                                     rowsRamp.remove(at: index)
                                 }) {
                                     Image(systemName: "minus.circle")
                                         .foregroundColor(.red)
                                 }
                             }
                         }
                         
                         //Add row tanjakan
                         Button("Add Row"){
                             rowsRamp.append("")
                         }
                     }
                 }
                 
                 //Akses Masuk
                 Group{
                     HStack{
                         Image(systemName: "figure.roll")
                         Toggle("Akses Masuk", isOn: $isOnEnterAccess)
                     }
                     
                     //Add Row Akses Masuk
                     if (isOnEnterAccess == true){
                         
                         //Isi Form Akses Masuk
                         ForEach(0..<rowsEnterAccess.count, id: \.self) { index in
                             HStack {
                                 VStack{
                                     HStack{
                                         Text("Lantai")
                                         TextField("Contoh: G", text: $floorEnterAccess)
                                             .textContentType(.givenName)
                                             .multilineTextAlignment(.leading)
                                         
                                     }
                                     HStack{
                                         Text("Lokasi")
                                         TextField("Depan Toko Bulan", text: $locationEnterAccess)
                                             .textContentType(.givenName)
                                             .multilineTextAlignment(.leading)
                                     }
                                 }
                                 
                                 //Delete Row Akses Masuk
                                 Button(action: {
                                     rowsEnterAccess.remove(at: index)
                                 }) {
                                     Image(systemName: "minus.circle")
                                         .foregroundColor(.red)
                                 }
                             }
                         }
                         
                         //Add Row Akses Masuk
                         Button("Add Row"){
                             rowsEnterAccess.append("")
                         }
                     }
                 }
                 
                 // Tempat Parkir Toggle
                 Group {
                     HStack{
                         Image(systemName: "figure.roll")
                         Toggle("Tempat Parkir", isOn: $isOnParking)
                     }
                     if (isOnParking == true){
                         
                         //Isi Form Akses Masuk
                         ForEach(0..<rowsParking.count, id: \.self) { index in
                             HStack {
                                 VStack{
                                     HStack{
                                         Text("Lantai")
                                         TextField("Contoh: G", text: $floorParking)
                                             .textContentType(.givenName)
                                             .multilineTextAlignment(.leading)
                                     }
                                     HStack{
                                         Text("Lokasi")
                                         TextField("Depan Toko Bulan", text: $locationParking)
                                             .textContentType(.givenName)
                                             .multilineTextAlignment(.leading)
                                     }
                                 }
                                 //Delete Row Akses Masuk
                                 Button(action: {
                                     rowsParking.remove(at: index)
                                 }) {
                                     Image(systemName: "minus.circle")
                                         .foregroundColor(.red)
                                 }
                             }
                         }
                         //Add Row Parkir
                         Button("Add Row"){
                             rowsParking.append("")
                         }
                     }
                 }
                 
                 // Tersedia Kursi Roda Toggle
                 Group {
                     HStack{
                         Image(systemName: "figure.roll")
                         Toggle("Tersedia Kursi Roda", isOn: $isOnAvailableWheelchair)
                     }
                     if (isOnAvailableWheelchair == true){
                         ForEach(0..<rowsWheelChair.count, id: \.self) { index in
                             HStack {
                                 VStack{
                                     HStack{
                                         Text("Lantai")
                                         TextField("Contoh: G", text: $floorAvailableWheelchair)
                                             .textContentType(.givenName)
                                             .multilineTextAlignment(.leading)
                                         
                                     }
                                     HStack{
                                         Text("Lokasi")
                                         TextField("Depan Toko Bulan", text: $locationAvailableWheelchair)
                                             .textContentType(.givenName)
                                             .multilineTextAlignment(.leading)
                                     }
                                 }
                                 
                                 //Delete Row Kursi Roda
                                 Button(action: {
                                     rowsWheelChair.remove(at: index)
                                 }) {
                                     Image(systemName: "minus.circle")
                                         .foregroundColor(.red)
                                 }
                             }
                         }
                         
                         //Add Row Kursi Roda
                         Button("Add Row"){
                             rowsWheelChair.append("")
                         }
                     }
                 }
                 
                 // Section Aksesibilitas
                 Section(footer: Text("Note : Berikan rating dengan objektif dan sesuai dengan tingkat aksesibilitas kursiroda")){
                     Text("Rating Aksesibilitas")
                         .fontWeight(.bold)
                     
                     VStack{
                         HStack {
                             
                             HStack {
                                 RatingView(selected: $selected, message: $message)
                             }
                             .padding(.top,4)
                             .padding(.bottom,4)
                             
                         }
//                         .alert(isPresented: $message) {
//                             Alert(title: Text("Rating Submit"), message: Text("You Rated \(self.selected + 1) out of 5 Star Rating"), dismissButton: .none)
//                         }
                     }
                 }
                 .multilineTextAlignment(.leading)
                 
                 
                 //Section Ulasan
                 Section(footer: Text("Note : Pastikan Ulasan tidak Mengandung unsur SARA dan ujaran kebencian")){
                     
                     Text("Ulasan")
                         .fontWeight(.bold)
                     VStack{
                         
                         TextField("Masukkan Judul", text: $titleReview)
                             .textContentType(.givenName)
                             .multilineTextAlignment(.leading)
                         
                     }
                     VStack{
                         TextField("Isi Ulasan", text: $descriptionReview)
                             .frame(height: 55)
                             .multilineTextAlignment(.leading)
                     }
                     
                     
                 }.multilineTextAlignment(.leading)
                 
                 
                 // Section Tambahkan File
                 Section(footer: Text("Note : Pastikan gambar terlihat jelas dan tidak mengandung SARA dan pornografi")){
                     VStack{
                         PhotosPicker("Masukkan Gambar", selection: $selectedItems, matching: .images)
                             .padding(.top,10)
                         LazyVStack {
                             ForEach(0..<selectedImages.count, id: \.self) { i in
                                 selectedImages[i]
                                     .resizable()
                                     .scaledToFit()
                                     .frame(width: 300, height: 300)
                             }
                         }
                         
                         
                         .onChange(of: selectedItems) { _ in
                             Task {
                                 selectedImages.removeAll()
                                 
                                 for item in selectedItems {
                                     if let data = try? await item.loadTransferable(type: Data.self) {
                                         if let uiImage = UIImage(data: data) {
                                             let image = Image(uiImage: uiImage)
                                             selectedImages.append(image)
                                         }
                                     }
                                 }
                             }
                         }
                     }
                     
                 }
                 .multilineTextAlignment(.leading)
                 
                 
             }
             .navigationTitle("Tambah Ulasan")
             .background(Color(.systemGray6))
             .navigationBarTitleDisplayMode(.inline)
             .multilineTextAlignment(.trailing)
             .toolbar{
                 ToolbarItem(placement: .confirmationAction){
                     Button("Tambah", action: {
                         
                     })
                 }
                 
                 ToolbarItem(placement: .cancellationAction) {
                     Button("Batal", action: {
                         dismissSheet()
                     })
                 }
             }
         }
     }
}

struct AddReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AddReviewView(rating: 1, maxRating: 5)
    }
}

struct RatingView : View {
    
    @Binding var selected : Int
    @Binding var message : Bool
    
    var body: some View {
        ForEach(0..<5) { rating in
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(self.selected >= rating ? .yellow : .gray)
                .onTapGesture {
                    self.selected = rating
                    self.message.toggle()
                }
        }
    }
}

