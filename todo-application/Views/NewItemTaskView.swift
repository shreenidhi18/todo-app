//
//  NewItemTaskView.swift
//  todo-application
//
//  Created by shreenidhi vm on 25/10/23.
//
//
import SwiftUI

struct NewItemTaskView: View {
    private var isButtonDisabled:Bool  {
        task.isEmpty
    }
    @Environment(\.managedObjectContext) private var viewContext
    @State private var task:String = ""
    @FocusState private var nameIsFocused: Bool
    @Binding var isShowing:Bool
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.id = UUID()
            newItem.task = task
            newItem.completed = false
            

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        task = ""
        isShowing = false
    }
    var body: some View {
        //vstack1 start
        VStack{
            Spacer()
            VStack(spacing: 16){
                TextField("New Task", text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size:24,weight: .bold,design: .rounded))
                    .padding()
                    
                    .background(Color("gray"))
                    .cornerRadius(10)
                    .focused($nameIsFocused)
                    
                Button{
                    nameIsFocused = false
                    addItem()
                }label: {
                    Spacer()
                    Text("SAVE")
                        .font(.system(size:24,weight: .bold,design: .rounded))
                    Spacer()
                }
                .disabled(isButtonDisabled)
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .background(isButtonDisabled ? Color.blue : Color.pink)
                .cornerRadius(10)

            }
            .padding(.horizontal)
            .padding(.vertical,20)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color:Color(red:0,green:0,blue:0,opacity:0.65),radius: 24)
            .frame(maxWidth: 640)

        }
        .padding()
        //vstack 1 end
    }
}

struct NewItemTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemTaskView(isShowing: .constant(true))
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
