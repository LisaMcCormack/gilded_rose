class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()

# SET UP LINTER ETC
# REMEMBER TO ADD IN NEW REQUIREMENTS

    # If the item is not Brie, Backstage passes or Sulfuras and the quality is greater than zero
    # then item quality decreases by one.
    @items.each do |item|
      if item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
        end
      else
      # this will increase the item quality by one if the item quality is less than 50
      # the quality for backstage passes increases by at least one depending on the sell_in number
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      # the sell_in number for all items decreases by one except for sulfuras
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      # after the sell_in, the items decrease twice as fast except for Brie, backstage passes and sulfuras
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          # the backstage passes quality is zero after the sell_in
          else
            item.quality = item.quality - item.quality
          end
        # brie further increases in quality - NEED TO CHECK THIS
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
