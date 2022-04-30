//
//  ProfileView.swift
//  The Eye
//
//  Created by Agus Hery on 26/04/22.
//

import SwiftUI


struct ProfileView: View {
    
    
    @Environment(\.managedObjectContext) var moc
    //@FetchRequest(sortDescriptors: []) var profiles: FetchedResults<Profile>
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var income: String
    @State var didEdit: Bool = true
    @State var editButton: String = "Edit"
    
    //@State var test: [Profile] = []
    
    var body: some View {
            VStack{
                Form {
                    Section{
                        HStack{
                            Spacer()
                            Image("Profile")
                                .resizable()
                                .clipped()
                                .frame(width: 150, height: 150, alignment: .center)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                                .overlay(Circle().stroke(Color.clear, lineWidth: 2.0))
                                .padding(.top,50)
                            Spacer()
                        }
                    }.listRowBackground(Color.clear)
                    Section(header: Text("Name")) {
                        HStack {
                            Text("Agus Hery")
                            NavigationLink {
                                Form {
                                    HStack {
                                        Text("First Name ")
                                        TextField("Enter First Name", text: $firstName)
                                            .disabled(didEdit)
                                            .padding(.leading,50)
                                    }
                                    HStack {
                                        Text("Last Name ")
                                        TextField("Enter Last Name", text: $lastName)
                                            .disabled(didEdit)
                                            .padding(.leading,50)
                                    }
                                }// form
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarTrailing) {
                                        Button{
                                            didEdit.toggle()
                                            if didEdit{
                                                self.editButton = "Edit"
                                            } else {
                                                self.editButton = "Done"
//                                                let newProfile = Profile(context: moc)
//                                                newProfile.firstname = firstName
//                                                newProfile.lastname = lastName
//                                                do {
//                                                    try self.moc.save()
//                                                } catch {
//                                                    print("whoops \(error.localizedDescription)")
//                                                }

                                            }
                                            print(didEdit)
                                        } label: {
                                            Text(editButton)
                                        }//button name
                                    }
                                }
                            }label: {
                                Text(firstName + lastName)
                            }
                        }
                    } // section name
//                    Section{
//                        test.income.map(Text.init)
//                            .font(.title)
//                    }
                    Section(header: Text("Income")){
                        HStack {
                            NavigationLink {
                                Form {
                                    HStack {
                                        Text("Income ")
                                        TextField("Enter Your Income", text: $income)
                                            .disabled(didEdit)
                                            .padding(.leading,50)
                                    }
                                } // form Income
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarTrailing) {
                                        Button{
                                            didEdit.toggle()
                                            if didEdit{
                                                self.editButton = "Edit"
                                            } else {
                                                print("ubah")
                                                self.editButton = "Done"
//                                                let newProfile = Profile(context: moc)
//                                                newProfile.income = income
//                                                do {
//                                                    try self.moc.save()
//                                                } catch {
//                                                    print("whoops \(error.localizedDescription)")
//                                                }
                                            }
                                            print(didEdit)
                                        } label: {
                                            Text(editButton)
                                        }//button income
                                    }
                                }
                            }label: {
                                Text("Rp. " + income)
                            }
                        }
                    }
                    // section income
                }
                //form
                .navigationBarTitle(Text("Profile"))
                .navigationBarTitleDisplayMode(.inline)
        }
    } // var body
} // struck

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(firstName: "", lastName: "", income: "")
            .previewInterfaceOrientation(.portrait)
    }
}
