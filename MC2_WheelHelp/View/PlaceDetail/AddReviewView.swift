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
    @State private var rows: [String] = [""]
    
    // Input Toilet Disabilitas
    @State private var floorToiletDisable = ""
    @State private var locationToiletDisable = ""
    
    // Input Lift
    @State private var floorLift = ""
    @State private var locationLift = ""
    
    // Input Lift
    @State private var floorRamp = ""
    @State private var locationRamp = ""
    
    // Input Lift
    @State private var floorEnterAccess = ""
    @State private var locationEnterAccess = ""
    
    // Input Lift
    @State private var floorParking = ""
    @State private var locationParking = ""
    
    // Input Lift
    @State private var floorAvailableWheelchair = ""
    @State private var locationAvailableWheelchair = ""
    
    // Input Image
    @State private var image: Image? = nil
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    @State var rating: CGFloat
    @State var maxRating: Int
    
    @State var selected = -1
    @State var message = false
    
    
    
    
    var body: some View {
        NavigationStack{
            //            VStack{
            //
            //            }
            VStack{
                HStack{
                    Image(systemName: "figure.roll")
                    Toggle("Eskalator", isOn: $isOnEscalator)
                    
                }
                if (isOnEscalator == true){
                    VStack{
                        List {
                            ForEach(0..<rows.count, id: \.self) { index in
                                HStack {
                                    TextField("Enter text", text: $rows[index])
                                        .textContentType(.givenName)
                                        .multilineTextAlignment(.leading)
                                    
                                    Button(action: {
                                        rows.remove(at: index)
                                    }) {
                                        Image(systemName: "minus.circle")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            
                            .onDelete { offsets in
                                rows.remove(atOffsets: offsets)
                            }
                        }
                        Button(action: {
                            rows.append("")
                        }) {
                            Text("Add Row")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                
                        
                   
                }
            }.padding(.leading,8)
                .padding(.trailing,8)
            
            Form{

                Section{
                    
                    // Eskalator Toggle
                    
                    
                    // Toilet Disabilitas Toggle
                    VStack {
                        HStack{
                            Image(systemName: "figure.roll")
                            Toggle("Toilet Disabilitas", isOn: $isOnToiletDisable)
                            
                        }
                        if (isOnToiletDisable == true){
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
                                
                                
                                
                            }.padding(.top,8)
                        }
                    }
                    
                    // Lift Toggle
                    VStack {
                        HStack{
                            Image(systemName: "figure.roll")
                            Toggle("Lift", isOn: $isOnLift)
                        }
                        if (isOnLift == true){
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
                                
                                
                                
                            }.padding(.top,8)
                        }
                    }
                    
                    // Tanjakan Toggle
                    VStack {
                        HStack{
                            Image(systemName: "figure.roll")
                            Toggle("Tanjakan", isOn: $isOnRamp)
                        }
                        if (isOnRamp == true){
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
                                
                                
                                
                            }.padding(.top,8)
                        }
                    }
                    
                    // Akses Masuk Toggle
                    VStack {
                        HStack{
                            Image(systemName: "figure.roll")
                            Toggle("Akses Masuk", isOn: $isOnEnterAccess)
                        }
                        if (isOnEnterAccess == true){
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
                                
                                
                                
                            }.padding(.top,8)
                        }
                    }
                    
                    // Tempat Parkir Toggle
                    VStack {
                        HStack{
                            Image(systemName: "figure.roll")
                            Toggle("Tempat Parkir", isOn: $isOnParking)
                        }
                        if (isOnParking == true){
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
                                
                                
                                
                            }.padding(.top,8)
                        }
                    }
                    
                    // Tersedia Kursi Roda Toggle
                    VStack {
                        HStack{
                            Image(systemName: "figure.roll")
                            Toggle("Tersedia Kursi Roda", isOn: $isOnAvailableWheelchair)
                        }
                        if (isOnAvailableWheelchair == true){
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
                                
                                
                                
                            }.padding(.top,8)
                        }
                    }
                    
                    
                }
                
                // Section Aksesibilitas
                
                Section(footer: Text("Note : Berikan rating dengan objektif dan sesuai dengan tingkat aksesibilitas kursiroda")){
                    Text("Rating Aksesibilitas")
                        .fontWeight(.bold)
                    
                    VStack{
                        VStack{
                            //                            Text("Ketuk untuk Menilai")
                            //    //                            .font(.system(size: 12))
                            //
                            //                                .padding(.bottom,16)
                            //                                .frame(alignment: .leading)
                        }
                        
                        
                        HStack {
                            //                            Text("Rating")
                            //                            Spacer()
                            
                            HStack {
                                RatingView(selected: $selected, message: $message)
                            }
                            .padding(.top,4)
                            .padding(.bottom,4)
                        }.alert(isPresented: $message) {
                            Alert(title: Text("Rating Submit"), message: Text("You Rated \(self.selected + 1) out of 5 Star Rating"), dismissButton: .none)
                        }
                        
                    }
                    //                    .multilineTextAlignment(.leading)
                    
                }
                .multilineTextAlignment(.leading)
                
                
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
    
    func deleteRow(at offsets: IndexSet) {
            rows.remove(atOffsets: offsets)
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

