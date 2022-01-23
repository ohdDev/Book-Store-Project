require 'libui'
require './Bookstore1.rb'
UI = LibUI

UI.init

should_quit = proc do
  puts 'Bye Bye'
  UI.control_destroy(MAIN_WINDOW)
  UI.quit
  0
end

=begin
  -- Window Description --
  new entry --> add item --> msg box "item added"
=end
def AddItemWindow()
  addItemWindow = UI.new_window('Add Item', 400, 600, 1)

  vbox_add_item = UI.new_vertical_box
  UI.window_set_child(addItemWindow,vbox_add_item)
  
  #entry button
  item_entry = UI.new_entry
  UI.entry_set_text(item_entry,
    "enter a new item,\n with the format title ,price, author name, number of pages, isbn\n")
    #do a group to set static title --> when u have time!!!
    #fix the display --> when u have time!!!

  entry = ""

  UI.entry_on_changed(item_entry) do |i|
    entry = UI.entry_text(i)
    puts "Current textbox data: '#{entry}'"
  end
  UI.box_append(vbox_add_item, item_entry, 1)

  #add item button
  add_item_button = UI.new_button("Add Item")

  p Bookstore1::Manager
  UI.button_on_clicked(add_item_button) do
    #check if input is either book or mag
    #display the format if book or mag
    #add to the desired file
    Bookstore1::Manager.AddItem(entry,"Books.txt")
    UI.msg_box(addItemWindow, 'Information', 'You added a new item!')
  end
    #if you have time fix the input validation!!!
    
  UI.box_append(vbox_add_item, add_item_button, 1)
  return addItemWindow
end

def DeleteItemWindow()
  deleteitemWindow = UI.new_window("", 400,600,1)
  
  return deleteitemWindow
end

def ListMostExpensiveWindow()
  listMostExp = UI.new_window("", 400,600,1)
  
  return listMostExp
end 
# new window 
# vbox - hbox 
# group --> child of hbox
# append 
# show
# close window
def show(name)

  # new_show = UI.new_window('Tab', 400, 600, 1)
  # vbox_show = UI.new_vertical_box
  # buttontest = UI.new_button("test")
  # UI.window_set_child(new_show,vbox_show)
  # UI.box_append(vbox_show,buttontest,1)
  case name
    when 'addItem' 
      puts "Hello?"
      the_window = AddItemWindow()

    when 'deleteItem'
      the_window = DeleteItemWindow()
    
    when 'listMostExpensive'
      the_window = ListMostExpensiveWindow()
    else 
      puts "error"
  end

  UI.control_show(the_window)

  UI.window_on_closing(the_window) do
      UI.control_destroy(the_window)
      0
  end
  
end

# Main Window
MAIN_WINDOW = UI.new_window('Book Store', 400, 600, 1)
UI.window_set_margined(MAIN_WINDOW, 1)
UI.window_on_closing(MAIN_WINDOW, should_quit)

vbox = UI.new_vertical_box
UI.window_set_child(MAIN_WINDOW, vbox)
hbox = UI.new_horizontal_box
UI.box_set_padded(vbox, 1)
UI.box_set_padded(hbox, 1)

UI.box_append(vbox, hbox, 1)

# Group - Basic Controls
group = UI.new_group('')
UI.group_set_margined(group, 1)
UI.box_append(hbox, group, 1) # OSX bug?

inner = UI.new_vertical_box
UI.box_set_padded(inner, 1)
UI.group_set_child(group, inner)

# Button1 -- Add store item
button = UI.new_button('Add store item')
UI.button_on_clicked(button) do

  show('addItem')
  
end
UI.box_append(inner, button, 0)

# Button2 -- List Most Expensive 
button2 = UI.new_button('List most expensive items')
UI.button_on_clicked(button2) do
  show('listMostExpensive')
end
UI.box_append(inner, button2, 0)

# Button3 -- List Books within Range
button3 = UI.new_button('List books within a range')
UI.button_on_clicked(button3) do
  show('listbooksrange')
end 
UI.box_append(inner, button3, 0)

# Button4 -- Search Magazine by date
button4 = UI.new_button('Search Magazine by date')
UI.button_on_clicked(button4) do
  show()
end
UI.box_append(inner, button4, 0)

# Button5 -- Search Magazine by publisher
button5 = UI.new_button('Search Magazine by publisher')
UI.button_on_clicked(button5) do
  show()
end
UI.box_append(inner, button5, 0)

# Button6 -- List all store items
button6 = UI.new_button('List all store items')
UI.button_on_clicked(button6) do
  show()
end
UI.box_append(inner, button6, 0)

# Button7 - Delete an item
button7 = UI.new_button('Delete an item')
UI.button_on_clicked(button7) do
  show('deleteItem')
end

UI.box_append(inner, button7, 0)




UI.control_show(MAIN_WINDOW)

UI.main
UI.quit