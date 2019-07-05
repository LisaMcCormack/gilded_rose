require File.join(File.dirname(__FILE__), '../lib/gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "decreases the quality by one of all items except Brie, Backstage passes and Sulfuras" do
      items = [Item.new("foo", 20, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 19
    end

    it "decreases the sell_in by one of all items except Brie, Backstage passes and Sulfuras" do
      items = [Item.new("foo", 20, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 19
    end

    it "decreases the quality by two of all items except Brie, Backstage passes and Sulfuras when sell_in is negative" do
      items = [Item.new("foo", -1, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 8
    end

    it "never allows the quality to be negative" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "will not decrease or increase the quality of Sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 50, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "will not decrease or increase the sell_in of Sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 50, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 50
    end

    it "does not allow the quality of an item to be more than 50" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 3, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "will increase the quality of backstage pass by one if sell in is 11 or more" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 12, 40)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 41
    end

    it "will increase the quality of backstage pass by two if sell in is between 10 and 6" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 40)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 42
    end

    it "will increase the quality of backstage pass by three if sell in is five or less" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 47)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "will increase the quality of brie by one when sell_in is zero or positive" do
      items = [Item.new("Aged Brie", 1, 49)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "will increase the quality of brie by two when sell_in is negative" do
      items = [Item.new("Aged Brie", -1, 48)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "will decrease the sell_in of all items except sulfuras" do
      items = [Item.new("Aged Brie", 8, 40)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 7
    end

    it "Backstage pass quality is zero when sell_in is negative" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "decreases the quality by two for all items except sulfuras when sell_in is negative" do
      items = [Item.new("foo", -1, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 8
    end

    it "decreases the quality by two for conjured" do
      items = [Item.new("Conjured", 20, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 8
    end



  end
end
