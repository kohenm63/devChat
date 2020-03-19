//
//  AccountCreation.swift
//  DevChatApp
//
//  Created by Mila Rabuchin on 07/03/2020.
//  Copyright © 2020 Mila Rabuchin. All rights reserved.
//

import SwiftUI
import Firebase

struct AccountCreation : View {
    
    @Binding var show : Bool
    @State var name = ""
    @State var about = ""
    @State var picker = false
    @State var loading = false
    @State var imagedata : Data = .init(count: 0)
    @State var alert = false
    
    var body : some View{
        
        VStack(alignment: .leading, spacing: 15){
            
            Text("Create An Account").font(.title)
            
            HStack{
                
                Spacer()
                
                Button(action: {
                    
                    self.picker.toggle()
                    
                }) {
                    
                    if self.imagedata.count == 0{
                        
                       Image(systemName: "person.crop.circle.badge.plus.fill").resizable().frame(width: 90, height: 70).foregroundColor(Color("4"))
                    }
                    else{
                        
                        Image(uiImage: UIImage(data: self.imagedata)!).resizable().renderingMode(.original).frame(width: 90, height: 90).clipShape(Circle())
                    }
                    
                    
                }
                
                Spacer()
            }
            .padding(.vertical, 15)
            
            Text("User Name")
               
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top, 12)
            
            

            TextField("Name", text: self.$name)
                     .keyboardType(.default)
                    .padding()
                    .background(Color("3"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 15)
            
            Text("Programming Language")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top, 12)

            TextField("Type here", text: self.$about)
                    .keyboardType(.default)
                    .padding()
                    .background(Color("3"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 15)
            
            if self.loading{
                
                HStack{
                    
                    Spacer()
                    
                    Indicator()
                    
                    Spacer()
                }
            }
                
            else{
                
                Button(action: {
                    
                    if self.name != "" && self.about != "" && self.imagedata.count != 0{
                        
                        self.loading.toggle()
                        CreateUser(name: self.name, about: self.about, imagedata: self.imagedata) { (status) in
                            
                            if status{
                                
                                self.show.toggle()
                            }
                        }
                    }
                    else{
                        
                        self.alert.toggle()
                    }
                    
                    
                }) {
                    

                Text("Create").frame(width: UIScreen.main.bounds.width - 30,height: 50)
                         
                }.foregroundColor(Color("4"))
                .background(Color("1"))
                .cornerRadius(10)
                .border(Color("4"))
                
            }
            
        }
        .padding()
        .sheet(isPresented: self.$picker, content: {
            
            ImagePicker(picker: self.$picker, imagedata: self.$imagedata)
        })
        .alert(isPresented: self.$alert) {
            
            Alert(title: Text("Message"), message: Text("Fill All The Contents and Add an Image"), dismissButton: .default(Text("Ok")))
        }
    }
}

