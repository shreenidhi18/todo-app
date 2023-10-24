//
//  BlankView.swift
//  todo-application
//
//  Created by shreenidhi vm on 25/10/23.
//

import SwiftUI

struct BlankView: View {
    var body: some View {
        VStack{
            Spacer()
            
        }
        .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity,alignment: .center)
        .ignoresSafeArea(.all)
        .background(Color.black)
        .opacity(0.5)
        
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView()
    }
}
