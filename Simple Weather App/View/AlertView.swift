//
//  AlertView.swift
//  Simple Weather App
//
//  Created by Renzo Paul Chamorro on 18/04/21.
//

import SwiftUI

struct AlertView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var showingAlert: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.circle")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
            Text("Ubicación no encontrada.")
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .fill((colorScheme == .dark ? Color.white : Color.black))
                .frame(width: 80, height: 35, alignment: .center)
                .overlay(
                    Button(action: {
                        showingAlert.toggle()
                    }, label: {
                        Text("OK")
                            .fontWeight(.semibold)
                            .foregroundColor((colorScheme == .dark ? Color.black : Color.white))
                            .font(.title2)
                    }))
            
        }
        .padding()
        .background(colorScheme == .dark ? Color.black : Color.white)
        .cornerRadius(20)
        .clipped()
        .shadow(color: .black, radius: 30, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5)
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AlertView(showingAlert: .constant(false))
                .preferredColorScheme(.light)
            AlertView(showingAlert: .constant(false))
                .preferredColorScheme(.dark)
        }
    }
}
