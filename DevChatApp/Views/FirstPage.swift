//
//  FirstPage.swift
//  DevChatApp
//
//  Created by Mila Rabuchin on 07/03/2020.
//  Copyright © 2020 Mila Rabuchin. All rights reserved.
//

import SwiftUI
import Firebase

struct FirstPage : View {
    
    @State var ccode = ""
    @State var no = ""
    @State var show = false
    @State var msg = ""
    @State var alert = false
    @State var ID = ""
    
    @State var value : CGFloat = 0
    
    var body : some View{
        
        VStack(spacing: 20){
            
            Spacer()
           
            
            HStack{
                
                TextField("+1", text: $ccode)
                    .keyboardType(.numberPad)
                    .frame(width: 45)
                    .padding()
                    .background(Color("4"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                   
                
                TextField("Phone Number", text: $no)
                    .keyboardType(.numbersAndPunctuation)
                    .padding()
                    .background(Color("4"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }.offset(y:-self.value).animation(.spring()).onAppear(){
                NotificationCenter.default.addObserver(forName:UIResponder.keyboardWillShowNotification, object: nil, queue: .main){ (notif)in
                    let value  = notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height
                    self.value = height
                    
                    
                }
                NotificationCenter.default.addObserver(forName:UIResponder.keyboardWillHideNotification, object: nil, queue: .main){ (notification)in
                                  
                self.value = 0
                                   
                                   
                               }
            }
                .padding(.top, 15)
                

            NavigationLink(destination: ScndPage(show: $show, ID: $ID), isActive: $show) {
                
                
                Button(action: {
                    
                    // remove this when testing with real Phone Number
                    
                    Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                    PhoneAuthProvider.provider().verifyPhoneNumber("+"+self.ccode+self.no, uiDelegate: nil) { (ID, err) in
                        
                        if err != nil{
                            
                            self.msg = (err?.localizedDescription)!
                            self.alert.toggle()
                            return
                        }
                        
                        self.ID = ID!
                        self.show.toggle()
                    }
                    
                    
                }) {
                    
                    Text("Send").frame(width: UIScreen.main.bounds.width - 30,height: 50).border(Color("4"))
                    
                }.foregroundColor(Color("3"))
                .background(Color("1"))
                .cornerRadius(10)
            }

            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
            
        }.padding()
            .background(Image("pic")
                .resizable()
                .scaledToFill()
                .clipped())
            
        .alert(isPresented: $alert) {
                
            Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
        }
    }
}

