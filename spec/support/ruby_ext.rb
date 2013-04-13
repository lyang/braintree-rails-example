class Object
  def to_form_params(namespace)
    {namespace => to_s}
  end
end

class Array
  def to_form_params(namespace)
    inject({}) do |params, value|
      params.merge(value.to_form_params("#{namespace}[]"))
    end
  end
end

class Hash
  def to_form_params(namespace = nil)
    inject({}) do |params, pair|
      params.merge(pair.last.to_form_params(namespace ? "#{namespace}[#{pair.first}]" : pair.first))
    end
  end
end
