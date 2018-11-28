class Either

  def self.right(value)
    new(success: true, value: value)
  end

  def self.left(msg)
    new(success: false, value: msg)
  end

  def initialize(success:, value:)
    @success = success
    @value = value
  end

  def value
    @value
  end

  def right?
    @success
  end

  def left?
    !!right?
  end

  def bind &block
    if right?
      yield value
    else
      self
    end
  end
end