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
    @State private var floorEscalator: [String] = [""]
    @State private var locationEscalator: [String] = [""]
    @State private var rows: [String] = []
    
    // Input Toilet Disabilitas
    @State private var floorToiletDisable: [String] = [""]
    @State private var locationToiletDisable: [String] = [""]
    
    // Input Lift
    @State private var floorLift: [String] = [""]
    @State private var locationLift: [String] = [""]
    
    // Input Lift
    @State private var descriptionRamp = ""
    
    // Input Lift
    @State private var descriptionEnterAccess = ""
    
    // Input Lift
    @State private var descriptionParking = ""
    
    // Input Lift
    @State private var descriptionAvailableWheelchair = ""
    
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
//            VStack{
//                HStack{
//                    Image(systemName: "figure.roll")
//                    Toggle("Eskalator", isOn: $isOnEscalator)
//
//                }
//                if (isOnEscalator == true){
//                    VStack{
//                        List {
//                            ForEach(0..<rows.count, id: \.self) { index in
//                                HStack {
//                                    TextField("Enter text", text: $rows[index])
//                                        .textContentType(.givenName)
//                                        .multilineTextAlignment(.leading)
//
//                                    Button(action: {
//                                        rows.remove(at: index)
//                                    }) {
//                                        Image(systemName: "minus.circle")
//                                            .foregroundColor(.red)
//                                    }
//                                }
//                            }
//
//                            .onDelete { offsets in
//                                rows.remove(atOffsets: offsets)
//                            }
//                        }
//                        Button(action: {
//                            rows.append("")
//                        }) {
//                            Text("Add Row")
//                                .padding()
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                        }
//                    }
//
//
//
//                }
//            }.padding(.leading,8)
//                .padding(.trailing,8)
            
            Form{
                
                Section{
                    
                    // Eskalator Toggle
                    VStack {
                        HStack{
                            Image(systemName: "figure.roll")
                            Toggle("Eskalator", isOn: $isOnEscalator)
                            
                        }
                        if (isOnEscalator == true){
                            VStack{
                                ForEach(floorEscalator.indices, id: \.self) { index in
                                        HStack {
                                            Text("Lantai \(index + 1)")
                                            TextField("Contoh: G", text: $floorEscalator[index])
                                                .textContentType(.givenName)
                                                .multilineTextAlignment(.leading)
                                        }
                                    }
                                ForEach(locationEscalator.indices, id: \.self) { index in
                                        HStack {
                                            Text("Lokasi \(index + 1)")
                                            TextField("Contoh: G", text: $locationEscalator[index])
                                                .textContentType(.givenName)
                                                .multilineTextAlignment(.leading)
                                        }
                                    }
                                
                                
                                
                            }.padding(.top,8)
                        }
                    }

                    
                    
                    // Toilet Disabilitas Toggle
                    VStack {
                        HStack{
                            Image(systemName: "figure.roll")
                            Toggle("Toilet Disabilitas", isOn: $isOnToiletDisable)
                            
                        }
                        if (isOnToiletDisable == true){
                            VStack{
                                ForEach(floorToiletDisable.indices, id: \.self) { index in
                                        HStack {
                                            Text("Lantai")
                                            TextField("Contoh: G", text: $floorToiletDisable[index])
                                                .textContentType(.givenName)
                                                .multilineTextAlignment(.leading)
                                        }
                                    }
                                ForEach(locationToiletDisable.indices, id: \.self) { index in
                                        HStack {
                                            Text("Lokasi")
                                            TextField("Contoh: G", text: $locationToiletDisable[index])
                                                .textContentType(.givenName)
                                                .multilineTextAlignment(.leading)
                                        }
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
                                ForEach(floorLift.indices, id: \.self) { index in
                                        HStack {
                                            Text("Lantai")
                                            TextField("Contoh: G", text: $floorLift[index])
                                                .textContentType(.givenName)
                                                .multilineTextAlignment(.leading)
                                        }
                                    }
                                ForEach(locationLift.indices, id: \.self) { index in
                                        HStack {
                                            Text("Lokasi")
                                            TextField("Contoh: G", text: $locationLift[index])
                                                .textContentType(.givenName)
                                                .multilineTextAlignment(.leading)
                                        }
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
                                    Text("Deskripsi")
                                    TextField("Contoh: G", text: $descriptionRamp)
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
                                    Text("Deskripsi")
                                    TextField("Contoh: G", text: $descriptionEnterAccess)
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
                                    Text("Deskripsi")
                                    TextField("Contoh: G", text: $descriptionParking)
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
                                    Text("Deskripsi")
                                    TextField("Contoh: G", text: $descriptionAvailableWheelchair)
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
                            eskalator_lantai: isOnEscalator ? floorEscalator : [],
                            eskalator_lokasi: isOnEscalator ? locationEscalator : [],
                            first_name: "Test", // Add your logic to retrieve the first name
                            id_place: "55050605498e6083ce60b15d", // Set the value based on the selected place's ID
                            image: imageAssets,
                            last_name: "Test", // Add your logic to retrieve the last name
                            lift_lantai: isOnLift ? floorLift : [],
                            lift_lokasi: isOnLift ? locationLift : [],
                            likes: 0, // Set initial likes count
                            place_name: "placeName1",
                            ramp: isOnRamp ? "\(descriptionRamp)" : "",
                            sedia_kursi_roda: isOnAvailableWheelchair ? "\(descriptionAvailableWheelchair)" : "",
                            tempat_prakir: isOnParking ? "\(descriptionParking)" : "",
                            title: titleReview,
                            toilet_lantai: isOnToiletDisable ? floorToiletDisable : [],
                            toilet_lokasi: isOnToiletDisable ? locationToiletDisable : [],
                            fsq_id =
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
    
    func deleteRow(at offsets: IndexSet) {
        rows.remove(atOffsets: offsets)
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
