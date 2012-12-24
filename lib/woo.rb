class Object
  # For Duck Typing reason
  def woo(method, *args, &block)
    # I did not use try, because it is only alias for send
    send(method, *args, &block) if respond_to? method
  end

end
