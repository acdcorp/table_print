module TablePrint
  class RowGroup
    include RowRecursion

    def initialize
      super
    end

    #### structural ####
    
    def collapse!
      @children.each(&:collapse!)
    end

    #### format ####
    
    # more of a structural method than actual formatting
    def format
      rows = @children
      rows ||= []
      rows = rows.collect { |row| row.format }

      return nil if rows.length == 0
      rows
    end

    #### helper ####

    def data_equal(other)

      return false unless children.length == other.children.length

      children.zip(other.children).all? { |row1, row2| row1.data_equal(row2) }
    end

    # this is a development tool, to show the structure of the row/row_group tree
    def vis(prefix="")
      if prefix == ""
        puts "columns: #{columns.inspect.to_s}"
      end

      puts "#{prefix}group"
      children.each{|c| c.vis(prefix + "  ")}
    end
  end
end
