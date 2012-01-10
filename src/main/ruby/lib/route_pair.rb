class RoutePair

  def initialize(method, route)
    @method = method
    @route = route
  end

  def ==(other)
    eql? other
  end

  def hash
    @method.hash + @route.hash
  end

  def eql?(other)
    other.instance_of? RoutePair && @method == other.get_method && @route == other.get_route
  end

  def get_route
    @route
  end

  def get_method
    @method
  end


end
