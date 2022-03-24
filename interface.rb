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

    #fileName entry button
    file_entry = UI.new_entry
    UI.entry_set_text(file_entry,
      "enter a new item,\n with the format title ,price, author name, number of pages, isbn\n")
      #do a group to set static title --> when u have time!!!
      #fix the display --> when u have time!!!
  
  # item entry
  file_entry = UI.new_entry
  UI.entry_set_text(file_entry,
    "type 'book' to choose book or 'magazine' to choose magazine \n")

    file_entry_val = ""

  UI.entry_on_changed(file_entry) do |i|
    file_entry_val = UI.entry_text(i).to_s
    puts "item: '#{file_entry_val}'"
  end

  UI.box_append(vbox_add_item, file_entry, 1)

  # item entry
  item_entry = UI.new_entry
  UI.entry_set_text(item_entry,
  "Enter book in this format: 
  title,price,author name,number of pages,isbn.
  Enter magazine in this format: 
  title,price,publisher-agent,publish-date.\n")

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
    if file_entry_val == "book"
    Bookstore1::Manager.AddItem(entry,"Books.txt")
    UI.msg_box(addItemWindow, 'Information', 'You added a new item!')

    elsif file_entry_val == "magazine"
      Bookstore1::Manager.AddItem(entry,"Magazines.txt")
      UI.msg_box(addItemWindow, 'Information', 'You added a new item!')
    end
  end
    #if you have time fix the input validation!!!
    
  UI.box_append(vbox_add_item, add_item_button, 1)
  return addItemWindow
end

 def ListMostExpensiveWindow()


  mostExWindow = UI.new_window('Most Expensive Item', 400, 600, 1)

  vbox_most_ex = UI.new_vertical_box
  UI.window_set_child(mostExWindow,vbox_most_ex)

  # Bookstore1::Manager
  moE =  Bookstore1::Manager.mostEx
  

  showB = "Title, Price, Author, Pages, ISBN"
  showB += "\n-----------------------------------------"
  moE.each do |book,i|
    showB += "\n#{book.Title}, #{book.Price}, #{book.AuthorName}, #{book.NumOfPages}, #{book.ISBN}\n"
  end

  most_ex_button = UI.new_button("List Items")

  # p Bookstore1::Manager
  UI.button_on_clicked(most_ex_button) do
    UI.msg_box(mostExWindow, 'Most 3 Expensive Books are:', showB)
  end
  
  UI.box_append(vbox_most_ex, most_ex_button, 1)
  return mostExWindow

end 

def ListPriceRangeWindow()
  listRangeWindow = UI.new_window('List books within a range', 400, 600, 1)

  vbox_price_range = UI.new_vertical_box
  UI.window_set_child(listRangeWindow,vbox_price_range)
  
  #  Low price entry
  low_entry = UI.new_entry
  UI.entry_set_text(low_entry,
    "Enter the lower price\n")

  low_entry_val = ""

  UI.entry_on_changed(low_entry) do |i|
    low_entry_val = UI.entry_text(i).to_s
    puts "lower price: '#{low_entry_val}'"
  end

  UI.box_append(vbox_price_range, low_entry, 1)

  #  high price entry
  high_entry = UI.new_entry
  UI.entry_set_text(high_entry,
    "Enter the higher price\n")

  high_entry_val = ""

  UI.entry_on_changed(high_entry) do |i|
    high_entry_val = UI.entry_text(i).to_s
    puts "higher data: '#{high_entry_val}'"
  end

  UI.box_append(vbox_price_range, high_entry, 1)

  #get range button
  get_range_button = UI.new_button("get range")

  Bookstore1::Manager
  rangeB = "Title, Price, Author, Pages, ISBN"
  rangeB += "\n-----------------------------------------"
  UI.button_on_clicked(get_range_button) do
    #check if input is either book or mag
    #display the format if book or mag
    #add to the desired file
    booksRange = Bookstore1::Manager.listRange(low_entry_val,high_entry_val)
    booksRange.each { |book,i|
      rangeB += "\n#{book.Title}, #{book.Price}, #{book.AuthorName}, #{book.NumOfPages}, #{book.ISBN}\n"
    }

    UI.msg_box(listRangeWindow, 'Rnge Books', rangeB)
  end
    #if you have time fix the input validation!!!
    
  UI.box_append(vbox_price_range, get_range_button, 0)
  return listRangeWindow

end

def SearchMagByDateWindow()

  searchByDateWindow = UI.new_window('Search Mags By Date', 400, 600, 1)

  vbox_search_by_date = UI.new_vertical_box
  UI.window_set_child(searchByDateWindow,vbox_search_by_date)
  
  #  Low price entry
  date_entry = UI.new_entry
  UI.entry_set_text(date_entry,
    "Enter date in the fourmela: dd-m-yyyy\n")

  date_entry_val = ""

  UI.entry_on_changed(date_entry) do |i|
    date_entry_val = UI.entry_text(i).to_s
    puts "lower price: '#{date_entry_val}'"
  end

  UI.box_append(vbox_search_by_date, date_entry, 1)

  #get search button
  search_button = UI.new_button("search")

  Bookstore1::Manager
  mag = "title,price,publisher-agent,date"
  mag += "\n-----------------------------------------"

  UI.button_on_clicked(search_button) do
    #check if input is either book or mag
    #display the format if book or mag
    #add to the desired file
    date_entry_val = date_entry_val.to_s
    searchMag = Bookstore1::Manager.SearchByDate(date_entry_val)
    searchMag.each { |mags,i| 
      mag += "\n#{mags.Title}, #{mags.Price}, #{mags.Publisher}, #{mags.Date}\n"
    }

    UI.msg_box(searchByDateWindow, "Mags that published at: #{date_entry_val}", mag)
  end
    #if you have time fix the input validation!!!
    
  UI.box_append(vbox_search_by_date, search_button, 0)
  return searchByDateWindow

end

def SearchMagByPublisherWindow()

  searchByPubWindow = UI.new_window('Search Mags By Publisher', 400, 600, 1)

  vbox_search_by_pub = UI.new_vertical_box
  UI.window_set_child(searchByPubWindow,vbox_search_by_pub)
  

  publisher_entry = UI.new_entry
  UI.entry_set_text(publisher_entry,
    "Enter publisher name\n")

    publisher_entry_val = ""

  UI.entry_on_changed(publisher_entry) do |i|
    publisher_entry_val = UI.entry_text(i).to_s
    puts "publisher name: '#{publisher_entry_val}'"
  end

  UI.box_append(vbox_search_by_pub, publisher_entry, 1)

  #get search button
  search_button = UI.new_button("search")

  Bookstore1::Manager
  

  UI.button_on_clicked(search_button) do
    mag = "title,price,publisher-agent,date"
    mag += "\n-----------------------------------------"
    #check if input is either book or mag
    #display the format if book or mag
    #add to the desired file
    # publisher_entry_val = publisher_entry_val.to_s
    searchMag = Bookstore1::Manager.SearchByPublisher(publisher_entry_val)
    searchMag.each { |mags,i| 
      mag += "\n#{mags.Title}, #{mags.Price}, #{mags.Publisher}, #{mags.Date}\n"
    }

    UI.msg_box(searchByPubWindow, "Mags that published by: #{publisher_entry_val}", mag)

  end
    #if you have time fix the input validation!!!
    
  UI.box_append(vbox_search_by_pub, search_button, 0)
  return searchByPubWindow

end

def DeleteItemWindow()

  deleteItemWindow = UI.new_window('Delete Item', 400, 600, 1)

  vbox_delete_item = UI.new_vertical_box
  UI.window_set_child(deleteItemWindow,vbox_delete_item)

  # item entry
  item_entry = UI.new_entry
  UI.entry_set_text(item_entry,
    "type 'book' to choose book or 'magazine' to choose magazine \n")

    item_entry_val = ""

  UI.entry_on_changed(item_entry) do |i|
    item_entry_val = UI.entry_text(i).to_s
    puts "item: '#{item_entry_val}'"
  end

  UI.box_append(vbox_delete_item, item_entry, 1)


  # title entry
  title_entry = UI.new_entry
  UI.entry_set_text(title_entry,
    "type item title to delete \n")

    title_entry_val = ""

  UI.entry_on_changed(title_entry) do |i|
    title_entry_val = UI.entry_text(i).to_s
    puts "item: '#{title_entry_val}'"
  end

  UI.box_append(vbox_delete_item, title_entry, 1)

  # delete button
  delete_button = UI.new_button("delete item")
  
  UI.button_on_clicked(delete_button) do
    #check if input is either book or mag
    #display the format if book or mag
    #add to the desired file
    deleteItem = Bookstore1::Manager.DeleteItem(title_entry_val ,item_entry_val)
    p deleteItem
    showI = "*****Item*****\n"

    if deleteItem.kind_of?(Array)

      if item_entry_val == "magazine"
        deleteItem.each do |mags|
          showI += "\n#{mags.Title}, #{mags.Price}, #{mags.Publisher}, #{mags.Date}\n"
        end
      elsif item_entry_val == "book"
        deleteItem.each do |book|
          showI += "\n#{book.Title}, #{book.Price}, #{book.AuthorName}, #{book.NumOfPages}, #{book.ISBN}\n"
        end
      end
    
      UI.msg_box(deleteItemWindow, 'delete item', showI)
    else
      UI.msg_box(deleteItemWindow, 'delete item', deleteItem)
    end
    

  end


  UI.box_append(vbox_delete_item, delete_button, 1)
  return deleteItemWindow

end

def ListItemWindow()

  listItemsWindow = UI.new_window('List All Item', 400, 600, 1)

  vbox_list_item = UI.new_vertical_box
  UI.window_set_child(listItemsWindow,vbox_list_item)


  # Bookstore1::Manager
  listArray =  Bookstore1::Manager.ListItem
  # p listArray

  showB = "*****BOOKS*****\n"
  showB += "\nTitle, Price, Author, Pages, ISBN"
  showB += "\n-----------------------------------------"
  listArray[0].each do |book,i|
    showB += "\n#{book.Title}, #{book.Price}, #{book.AuthorName}, #{book.NumOfPages}, #{book.ISBN}\n"
  end

  showB += "\n*****MAGAZINES*****\n"
  showB += "\nTitle, Price, Publisher, Date"
  showB += "\n-----------------------------------------"
  listArray[1].each do |mags,i|
    showB += "\n#{mags.Title}, #{mags.Price}, #{mags.Publisher}, #{mags.Date}\n"
  end
  

  list_button = UI.new_button("List All Items")
  
  UI.button_on_clicked(list_button) do
      UI.msg_box(listItemsWindow, 'List All Items', showB)
  end

  UI.box_append(vbox_list_item, list_button, 1)
  return listItemsWindow

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
    
    when 'listbooksrange'
      the_window = ListPriceRangeWindow()
    
    when 'searchbydate'
      the_window = SearchMagByDateWindow()
    
    when 'searchbypublisher'
      the_window = SearchMagByPublisherWindow()
    
    when 'listitem'
      the_window = ListItemWindow()

    when 'deleteitem'
      the_window = DeleteItemWindow()

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
  show('searchbydate')
end
UI.box_append(inner, button4, 0)

# Button5 -- Search Magazine by publisher
button5 = UI.new_button('Search Magazine by publisher')
UI.button_on_clicked(button5) do
  show('searchbypublisher')
end
UI.box_append(inner, button5, 0)

# Button6 -- List all store items
button6 = UI.new_button('List all store items')
UI.button_on_clicked(button6) do
  show('listitem')
end
UI.box_append(inner, button6, 0)

# Button7 - Delete an item
button7 = UI.new_button('Delete an item')
UI.button_on_clicked(button7) do
  show('deleteitem')
end

UI.box_append(inner, button7, 0)




UI.control_show(MAIN_WINDOW)

UI.main
UI.quit