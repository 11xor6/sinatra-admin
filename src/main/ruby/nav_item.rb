class NavItem
  @@nav_items = Set.new
  @@static_items = Set.new

  def NavItem::add_item(item)
    if item.is_a? NavItem
      if (@@nav_items.add? item).nil?
        puts "NavItem already exists"
        throw "NavItem already exists"
      end
      puts "Added route for " + item.get_href
    else
      puts "Invalid NavItem"
      throw "Invalid NavItem"
    end
  end

  def NavItem::add_static_item(item)
    if item.is_a? NavItem
      if (@@static_items.add? item).nil?
        puts "NavItem already exists"
        pp @@static_items
        throw "NavItem already exists"
      end
      puts "Added static route for " + item.get_href
    else
      puts "Invalid NavItem"
      throw "Invalid NavItem"
    end
  end

  def NavItem::get_items
    @@static_items.to_a + @@nav_items.to_a
  end

  def NavItem::clear_items
    @@nav_items = Set.new
    puts "NavItems cleared"
  end

  def initialize(href, name)
    @href = href
    @name = name

    def get_href
      @href
    end

    def get_name
      @name
    end

    def eql?(other)
      self.get_href.equal?(other.get_href)
    end

    def ==(other)
      self.eql?(other)
    end

    def hash
      self.get_href.hash * 42
    end

  end
end
