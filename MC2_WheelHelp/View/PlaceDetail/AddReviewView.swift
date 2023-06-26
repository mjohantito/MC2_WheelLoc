//
//  AddReviewView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 26/06/23.
//

import SwiftUI

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
    
    @State private var image: Image? = nil


    
    
    
    var body: some View {
        NavigationStack{
//            VStack{
//
//            }
            
            Form{
                Section{
                    
                    HStack{
                        Text("Nama")
                        TextField("Masukkan Nama", text: $enterName)
                            .textContentType(.givenName)
                        
                    }.multilineTextAlignment(.leading)
                    
                }
                Section{
                    
                    // Eskalator Toggle
                    VStack{
                        HStack{
                            Image(systemName: "figure.roll")
                            Toggle("Eskalator", isOn: $isOnEscalator)
                                
                        }
                        if (isOnEscalator == true){
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
                Section{
                    Text("Aksesibilitas")
                        .fontWeight(.bold)
                    VStack{
                        Text("Ketuk untuk Menilai")
                            .font(.system(size: 12))
                            .padding(.bottom,16)
                        HStack{
                            Image(systemName: "figure.roll")
                                
                        }
                        
                    }
            
                    .frame(alignment: .leading)
                }
                
                
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
                Section{
                    
                }
                
                
                
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
        AddReviewView()
    }
}
