class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      resp.write display_cart
    elsif req.path.match(/add/)
      desired_item = req.params["item"]
      resp.write add_to_cart(desired_item)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def self.cart
    @@cart
  end

  def display_cart
    if self.class.cart.length == 0
      "Your cart is empty"
    else
      self.class.cart.map do |item|
        "#{item}\n"
      end.join("")
    end
  end

  def add_to_cart(desired_item)
      if @@items.include?(desired_item)
        @@cart << desired_item
        "added #{desired_item}"
      else
        "We don't have that item"
      end
  end

end
