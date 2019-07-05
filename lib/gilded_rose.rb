class GildedRose

  SPECIAL_ITEMS = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros", "Conjured"]

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      normal_items_sell_in(item)
      normal_items_quality(item) if normal_items?(item.name)
      brie(item) if item.name == "Aged Brie"
      backstage_passes(item) if item.name == "Backstage passes to a TAFKAL80ETC concert"
      conjured(item) if item.name == "Conjured"
    end
  end


  private

  def normal_items_sell_in(item)
    if item.name != "Sulfuras, Hand of Ragnaros"
      item.sell_in -= 1
    end
  end

  def conjured(item)
    item.quality -= 2 if item.quality > 1
  end

  def normal_items_quality(item)
    if item.quality > 0
      item.sell_in > 0 ?  item.quality -= 1 : item.quality -= 2
    end
  end

  def brie(item)
    item.sell_in >= 0 ? item.quality += 1 : item.quality += 2
  end

  def normal_items?(item)
    !SPECIAL_ITEMS.include?(item)
  end


  def backstage_passes(item)
    item.quality += 1 if item.sell_in > 10
    item.quality += 2 if item.sell_in < 11 && item.sell_in > 5
    item.quality += 3 if item.sell_in < 6 && item.quality <= 47
    item.quality = 0 if item.sell_in < 0
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
