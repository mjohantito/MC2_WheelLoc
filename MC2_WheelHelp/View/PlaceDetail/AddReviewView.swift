//
//  AddReviewView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 26/06/23.
//

import SwiftUI
import PhotosUI
import CloudKit

extension Image {
    func toUIImage() -> UIImage? {
        guard let imageData = self.asUIImage()?.jpegData(compressionQuality: 1.0) else {
            return nil
        }
        return UIImage(data: imageData)
    }
    
    private func asUIImage() -> UIImage? {
        guard let window = UIApplication.shared.windows.first else {
            return nil
        }
        
        let controller = UIHostingController(rootView: self)
        controller.view.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        window.addSubview(controller.view)
        
        let targetSize = controller.view.systemLayoutSizeFitting(
            CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .required
        )
        controller.view.bounds = CGRect(origin: .zero, size: targetSize)
        controller.view.sizeToFit()
        
        let renderer = UIGraphicsImageRenderer(bounds: controller.view.bounds)
        let image = renderer.image { _ in
            controller.view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
        
        controller.view.removeFromSuperview()
        
        return image
    }
}

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
    @State private var escalatorRows: [EscalatorRow] = []
    @State private var arrayFloorEscalator: [String] = [""]
    @State private var arrayLocationEscalator: [String] = [""]
    
    // Input Toilet Disabilitas
    @State private var floorToiletDisable = ""
    @State private var locationToiletDisable = ""
    @State private var rowsToilet: [String] = [""]
    @State private var toiletDisableRows: [ToiletDisableRow] = []
    @State private var arrayFloorToiletDisable: [String] = [""]
    @State private var arrayLocationToiletDisable: [String] = [""]
    
    // Input Lift
    @State private var floorLift = ""
    @State private var locationLift = ""
    @State private var rowsLift: [String] = [""]
    @State private var liftRows: [LiftRow] = []
    @State private var arrayFloorLift: [String] = [""]
    @State private var arrayLocationLift: [String] = [""]
    
    // Input Tanjakan
    @State private var descriptionRamp = ""
    //    @State private var floorRamp = ""
    //    @State private var locationRamp = ""
    //    @State private var rowsRamp: [String] = [""]
    
    
    // Input Enter Access
    @State private var descriptionEnterAccess = ""
    //    @State private var floorEnterAccess = ""
    //    @State private var locationEnterAccess = ""
    //    @State private var rowsEnterAccess: [String] = [""]
    
    // Input Parkir
    @State private var descriptionParking = ""
    //    @State private var floorParking = ""
    //    @State private var locationParking = ""
    //    @State private var rowsParking: [String] = [""]
    
    // Input WheelChair
    @State private var descriptionAvailableWheelchair = ""
    //    @State private var floorAvailableWheelchair = ""
    //    @State private var locationAvailableWheelchair = ""
    //    @State private var rowsWheelChair: [String] = [""]
    
    // Input Image
    @State private var image: Image? = nil
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    @State var rating: CGFloat
    @State var maxRating: Int
    @State var fsq_id: String
    @State var placeName: String
    @Binding var userEmail: String
    
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
                        ForEach(escalatorRows.indices, id: \.self) { index in
                            HStack {
                                VStack {
                                    HStack {
                                        Text("Lantai")
                                        TextField("Contoh: G", text: $escalatorRows[index].floor)
                                            .textContentType(.givenName)
                                            .multilineTextAlignment(.leading)
                                    }
                                    HStack {
                                        Text("Lokasi")
                                        TextField("Depan Toko Bulan", text: $escalatorRows[index].location)
                                            .textContentType(.givenName)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                                
                                Button(action: {
                                    escalatorRows.remove(at: index)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        
                        Button("Add Row") {
                            escalatorRows.append(EscalatorRow(floor: "", location: ""))
                            for escalatorRow in escalatorRows {
                                arrayFloorEscalator.append(escalatorRow.floor)
                                arrayLocationEscalator.append(escalatorRow.location)
                            }
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
                        ForEach(toiletDisableRows.indices, id: \.self) { index in
                            HStack {
                                VStack {
                                    HStack {
                                        Text("Lantai")
                                        TextField("Contoh: G", text: $toiletDisableRows[index].floor)
                                            .textContentType(.givenName)
                                            .multilineTextAlignment(.leading)
                                    }
                                    HStack {
                                        Text("Lokasi")
                                        TextField("Depan Toko Bulan", text: $toiletDisableRows[index].location)
                                            .textContentType(.givenName)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                                
                                Button(action: {
                                    toiletDisableRows.remove(at: index)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        
                        Button("Add Row") {
                            toiletDisableRows.append(ToiletDisableRow(floor: "", location: ""))
                            for toiletDisableRow in toiletDisableRows {
                                arrayFloorToiletDisable.append(toiletDisableRow.floor)
                                arrayLocationToiletDisable.append(toiletDisableRow.location)
                            }
                        }
                        
                    }
                }
                
                // Lift Toggle
                Group {
                    HStack{
                        Image(systemName: "figure.roll")
                        Toggle("Lift", isOn: $isOnLift)
                    }
                    
                    //Add Row Lift
                    if (isOnLift == true){
                        ForEach(liftRows.indices, id: \.self) { index in
                            HStack {
                                VStack {
                                    HStack {
                                        Text("Lantai")
                                        TextField("Contoh: G", text: $liftRows[index].floor)
                                            .textContentType(.givenName)
                                            .multilineTextAlignment(.leading)
                                    }
                                    HStack {
                                        Text("Lokasi")
                                        TextField("Depan Toko Bulan", text: $liftRows[index].location)
                                            .textContentType(.givenName)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                                
                                Button(action: {
                                    liftRows.remove(at: index)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        
                        Button("Add Row") {
                            liftRows.append(LiftRow(floor: "", location: ""))
                            for liftRow in liftRows {
                                arrayFloorLift.append(liftRow.floor)
                                arrayLocationLift.append(liftRow.location)
                            }
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
                        VStack(alignment: .leading) {
                            Text("Deskripsi")
                            TextField("Masukkan Deskripsi", text: $descriptionRamp)
                                .textContentType(.givenName)
                                .multilineTextAlignment(.leading)
                            
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
                        
                        VStack(alignment: .leading) {
                            Text("Deskripsi")
                            TextField("Masukkan Deskripsi", text: $descriptionEnterAccess)
                                .textContentType(.givenName)
                                .multilineTextAlignment(.leading)
                            
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
                        
                        VStack(alignment: .leading) {
                            Text("Deskripsi")
                            TextField("Masukkan Deskripsi", text: $descriptionParking)
                                .textContentType(.givenName)
                                .multilineTextAlignment(.leading)
                            
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
                        VStack(alignment: .leading) {
                            Text("Deskripsi")
                            TextField("Masukkan Deskripsi", text: $descriptionAvailableWheelchair)
                                .textContentType(.givenName)
                                .multilineTextAlignment(.leading)
                            
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
                        let imageAssets = selectedImages.compactMap { image in
                            if let data = imageToData(image) {
                                let url = saveImageToTemporaryDirectory(data: data)
                                return CKAsset(fileURL: url)
                            }
                            return nil
                        }
                        
                        addReviewToCloudKit(
                            accessibility_rating: Int64(selected + 1),
                            akses_masuk: isOnEnterAccess ? "\(descriptionEnterAccess)" : "",
                            date: Date(),
                            description: descriptionReview,
                            eskalator_lantai: isOnEscalator ? arrayFloorEscalator: [],
                            eskalator_lokasi: isOnEscalator ? arrayLocationEscalator : [],
                            first_name: "Test", // Add your logic to retrieve the first name
                            id_place: fsq_id, // Set the value based on the selected place's ID
                            image: imageAssets,
                            last_name: "Test", // Add your logic to retrieve the last name
                            lift_lantai: isOnLift ? arrayFloorLift : [],
                            lift_lokasi: isOnLift ? arrayLocationLift : [],
                            likes: 0, // Set initial likes count
                            place_name: placeName,
                            ramp: isOnRamp ? "\(descriptionRamp)" : "",
                            sedia_kursi_roda: isOnAvailableWheelchair ? "\(descriptionAvailableWheelchair)" : "",
                            tempat_prakir: isOnParking ? "\(descriptionParking)" : "",
                            title: titleReview,
                            toilet_lantai: isOnToiletDisable ? arrayFloorToiletDisable : [],
                            toilet_lokasi: isOnToiletDisable ? arrayLocationToiletDisable : [],
                            email_user: userEmail
                        )
                        
                        dismissSheet()
                        
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
    
    func imageToData(_ image: Image) -> Data? {
        guard let uiImage = image.toUIImage() else {
            return nil
        }
        return uiImage.jpegData(compressionQuality: 0.8)
    }
    
    func saveImageToTemporaryDirectory(data: Data) -> URL {
        let temporaryDirectory = FileManager.default.temporaryDirectory
        let uniqueFilename = ProcessInfo.processInfo.globallyUniqueString
        let fileURL = temporaryDirectory.appendingPathComponent(uniqueFilename).appendingPathExtension("jpg")
        
        try? data.write(to: fileURL)
        
        return fileURL
    }
}



struct AddReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AddReviewView(rating: 1, maxRating: 5, fsq_id:"default", placeName: "default", userEmail: .constant("example@example.com"))
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

