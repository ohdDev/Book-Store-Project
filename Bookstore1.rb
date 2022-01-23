module Bookstore1

  class StoreItem

    attr_accessor :Price, :Title
      
      def initialize(p,t)
        @Price = price

        @Title = title
      end
  end 

  class Book < StoreItem
    attr_accessor :AuthorName, :NumOfPages, :ISBN
    
    def initialize(title,price,authorname, numofpages, isbn)
      
      @AuthorName = authorname
      
      @NumOfPages = numofpages
      
      @ISBN = isbn
      
      @Price = price

      @Title = title
      
    end

    def display()
        
      puts "-----------------------------"
      puts "           ITEM              "
      puts "-----------------------------"

      puts "Title:           #{@Title}"
      puts "Price:           #{@Price}"
      puts "Auhtor Name:     #{@AuthorName}"
      puts "Number of Pages: #{@NumOfPages}"
      puts "ISBN:            #{@ISBN}"
      

    end
  end

  class Magazine < StoreItem
    attr_accessor :Publisher, :Date
      
    def initialize(title,price,publisher, date)
        
      @Publisher = publisher

      @Date = date
    
      @Price = price

      @Title = title

    end
      
    def display()
      puts "-----------------------------"
      puts "           ITEM              "
      puts "-----------------------------"

      puts "Title:           #{@Title}"
      puts "Price:           #{@Price}"
      puts "Publisher-Agent: #{@Publisher}"
      puts "Date:            #{@Date}"
    end
  end

  class LibraryManager
  
    
    def initialize()
      @books = Array.new
    end

    def AddItem(item,fileName)
    
      # m = [item.Title,item.Price,item.AuthorName,item.NumOfPages,item.ISBN]
      File.write(fileName,"\n",mode: "a")
      File.write(fileName, item, mode: "a")
      item.display()
      # @books << item

    end
  

    # read all data from book.txt and return it in array
    def readItems(fileName)
      item = []
      File.readlines(fileName).drop(1).each do |line| 
          bookItem = item.push(line.split(/,+/).map(&:chomp) )
      end 
      return item
    end

  
    #list most 3 expensive books
    def mostEx

      # maxList = []
      maxPrice = []
      priceArr = []

      books = readItems("Books.txt")

      books.each do |i|
        priceArr.push(i[1].to_f)
      end 

    # fill maxprice array with most 3 expensive prices index
       maxPrice = priceArr.each_index.max_by(3){|i| priceArr[i]}

          # fill maxList array with most 3 expensive books
          maxPrice.each { |el| 
          item = Book.new(books[el][0],books[el][1],books[el][2],books[el][3],books[el][4])
          item.display()
          }
  
    end
  
    #return books within p1-p2 range
    def listRange (p1,p2)
      priceRange = []
      # booksRange =[]
      priceArr = []
    
      #extract price from book.txt and convret it to float
      books = readItems("Books.txt")
      books.each do |i|
          priceArr.push(i[1].to_f)
      end

      priceRange = priceArr.each_index.select{|i| priceArr[i] >= p1 && priceArr[i] <= p2}
       
      
      # fill maxList array with most 3 expensive books
      priceRange.each { |el|
        item = Book.new(books[el][0],books[el][1],books[el][2],books[el][3],books[el][4])
        item.display()
      }
      
    end
   
  
    def SearchByPublisher(publisher)
  
      #mags-> search by date, publisher
    
      mags = readItems("Magazines.txt")
      mags.each_index.select{ |el| if (publisher == mags[el][2])
      item = Magazine.new(mags[el][0],mags[el][1],mags[el][2],mags[el][3])
      item.display() end }
    
    end
  
    def SearchByDate(date)
  
      #mags-> search by date, publisher
    
      mags = readItems("Magazines.txt")
      mags.each_index.select{ |el| if (date == mags[el][3])
      item = Magazine.new(mags[el][0],mags[el][1],mags[el][2],mags[el][3])
      item.display() end }
    
    

    def DeleteItem(itemToDel, fileName)
    
      #checking statement if exsists delete,
        #else "error msg"
        

    end

    def ListItem

      #books-> price range
      #list all items (mags, books)
      books = readItems("Books.txt")
      mags = readItems("Magazines.txt")


      puts "\n***BOOKS***\n"
      books.each_index.select {|i|
           bObj = Book.new(books[i][0],books[i][1],books[i][2],books[i][3],books[i][4])
           bObj.display()
      }
      
      puts "\n***MAGAZINES***\n"
      mags.each_index.select {|i|
          mObg = Magazine.new(mags[i][0],mags[i][1],mags[i][2],mags[i][3])
          mObg.display()
      }
     
      
    end
  
  end

  def seed(manager)
    File.open('Books.txt', 'r').each_line.with_index do |line,i|

      if i == 0
        next
      end
  
      itemInfo = line.split(",")
      
      item = Book.new(itemInfo[0],itemInfo[1],itemInfo[2],itemInfo[3],itemInfo[4])

      item.display()
    end
  
    File.open('Magazines.txt', 'r').each_line do |line|
      puts "Gooogle! #{line}"
    end

  end

  Manager = LibraryManager.new()
  # puts manager.DeleteItem("new t2", "Books.txt")
  # manager.ListItem()
  # manager.SearchByDate("14-6-2021")
  # manager.mostEx
  # manager.listRange(80,100)
  # seed(manager)
  # n = Book.new("new t2",63,"new aa",98,76654)
  # manager.AddItem(n,"Books.txt")
  # manager.mostEx
end