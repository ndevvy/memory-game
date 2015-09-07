class Card
  attr_reader :val

  def initialize(val)
    @val = val.to_sym
    @visible = false
  end

  def visible?
    @visible
  end

  def hide
    @visible = false
  end

  def reveal
    @visible = true
  end

  def to_s
    self.val.to_s
  end

  def ==(other_card)
    self.val == other_card.val
  end
end
