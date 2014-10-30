module HappyMapper
  class Attribute < Item
    attr_accessor :default

    # @see Item#initialize
    # Additional options:
    #   :default => Object The default value for this
    def initialize(name, type, o={})
      super
      self.default = o[:default]
    end

    def find(node, namespace, xpath_options)
      if self.namespace
        # from the class definition
        namespace = self.namespace
      elsif options[:namespace]
        namespace = options[:namespace]
      end

      if options[:xpath]
        result = node.xpath(options[:xpath], xpath_options)
      else
        result = node.xpath(xpath(namespace), xpath_options)
      end

      if result
        yield(result.first[self.options[:name]])
      end
    end
  end
end
