//
//  ContentView.swift
//  todo-application
//
//  Created by shreenidhi vm on 24/10/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var task:String = ""
    @FocusState private var nameIsFocused: Bool
    @State private var showNewTaskItem:Bool = false
    @AppStorage("isDarkMode") private var isDarkMode:Bool = false
    private var isButtonDisabled:Bool  {
        task.isEmpty
    }

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        //navigationview start
        ZStack{
            
            
                //zstack 1 start
                ZStack {
                    LinearGradient(colors: [.pink,.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    //vstack 1 start
                    VStack {
                        Spacer(minLength: 80)
                        HStack(spacing: 10){
                            Text("To-Do")
                                .font(.system(.largeTitle,design: .rounded))
                                .fontWeight(.heavy)
                                .padding(.leading,4)
                            Spacer()
                            EditButton()
                                .font(.system(size:20,weight: .semibold,design: .rounded))
                                .padding(10)
                                .frame(minWidth: 70,minHeight: 24)
                                .background(Capsule().stroke(Color.white,lineWidth:2))
                            Button{
                                isDarkMode.toggle()
                                
                            }label: {
                                Image(systemName: isDarkMode ? "moon.circle.fill":"moon.circle")
                                    .resizable()
                                    .frame(width: 30,height: 30)
                                    .font(.system(.title,design: .rounded))
                            }
                        }
                        .padding()
                        .foregroundColor(.white)
                        Spacer(minLength: 80)
                        Button{
                            showNewTaskItem = true
                        }label: {
                            Image(systemName: "plus.circle")
                                .font(.system(size:30,weight: .semibold,design: .rounded))
                            Text("New Task")
                                .font(.system(size:24,weight: .bold,design: .rounded))
                        }
                        .foregroundColor(.white)
                        .padding(.vertical,15)
                        .padding(.horizontal,20)
                        .background(LinearGradient(colors: [.pink,.blue], startPoint: .leading, endPoint: .trailing))
                        .clipShape(Capsule())
                        .shadow(color:Color(red:0,green:0,blue:0,opacity:0.25),radius: 8,x: 0,y: 4)
                        
                        
                        
                        //vstack 2 start
                        VStack(spacing: 16){
                            //                        TextField("New Task", text: $task)
                            //                            .padding()
                            //                            .background(Color("gray"))
                            //                            .cornerRadius(10)
                            //                            .focused($nameIsFocused)
                            //                        Button{
                            //                            nameIsFocused = false
                            ////                            addItem()
                            //                        }label: {
                            //                            Spacer()
                            //                            Text("SAVE")
                            //                            Spacer()
                            //                        }
                            //                        .disabled(isButtonDisabled)
                            //                        .padding()
                            //                        .font(.headline)
                            //                        .foregroundColor(.white)
                            //                        .background(isButtonDisabled ? Color.gray : Color.pink)
                            //                        .cornerRadius(10)
                            
                        }
                        .padding()
                        //vstack 2 end
                        //list start
                        List {
                            ForEach(items) { item in
                                VStack(alignment: .leading){
                                    Text(item.task ?? "")
                                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                            .onDelete(perform: deleteItems)
                        }
                        .listStyle(InsetGroupedListStyle())
                        .scrollContentBackground(.hidden)
                        .shadow(color:Color(red:0,green:0,blue:0,opacity:0.3),radius: 12)
                        .padding(.vertical,0)
                        .frame(maxWidth: 640)
                        //list end
                        
                    }
                    // vstack 1 end
                    if showNewTaskItem{
                        BlankView()
                            .onTapGesture {
                                showNewTaskItem = false
                            }
                        NewItemTaskView(isShowing: $showNewTaskItem)
                    }
                    
                    
                }
                .onAppear(){
                    UITableView.appearance().backgroundColor = UIColor.clear
                }
                //zstack 1 end
                .navigationTitle("Daily Tasks")
                .navigationBarHidden(true)
                
                
                
                
                
                
                //toolbar start
                //            .toolbar {
                //                ToolbarItem(placement: .navigationBarTrailing) {
                //                    EditButton()
                //                        .foregroundColor(.white)
                //                }
                //
                //            }.background(backgroudnGradient)
                //toolbar end
                
                
                
                
                
            
        }
        .background(LinearGradient(colors: [.pink,.blue], startPoint: .topLeading, endPoint: .bottomTrailing))
        
        
        
        .ignoresSafeArea(.all)
        //navigationView end
    }

   

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
