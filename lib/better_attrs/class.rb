class Class
  private

  alias_method :original_attr_accessor, :attr_accessor

  def attr_accessor(*args)
    attr_reader *extract_attrs_from_args(args)
    attr_writer *args
  end

  alias_method :original_attr_writer, :attr_writer

  def attr_writer(*args)
    attrs = extract_attrs_from_args(args)
    opts = extract_opts_from_args(args)
    attrs.each { |attr| define_attr_writer(attr, opts) }
  end

  def callback_for_attr(attr, opts)
    opts[:"#{attr}_changed"] || opts[:"#{attr}_updated"]
  end

  def define_attr_writer(attr, opts)
    class_eval do
      # Memoized state
      instance_variable = instance_variable_for_attr(attr)
      callback = callback_for_attr(attr, opts)
      writer_method = writer_method_for_attr(attr)

      define_method(writer_method) do |new_value|
        # Capture the `old_value`
        old_value = instance_variable_get(instance_variable)

        # Short-circuit if the values are the same
        return new_value if old_value == new_value

        # Update the instance-variable
        instance_variable_set(instance_variable, new_value)

        # Update the attributes `Hash` if it is present
        send(:[]=, attr, new_value) if defined?(::Rails) && respond_to?(:attributes)

        # Short-circuit if no callback was specified
        return new_value if callback.nil?

        # Callable object (e.g. `Proc`, `Lambda`)
        instance_exec(old_value, new_value, &callback) if callback.respond_to?(:call)

        # Method name (must be `String` or `Symbol`)
        send(callback, old_value, new_value) if [String, Symbol].include?(callback.class)
      end
    end
  end

  def extract_attrs_from_args(args)
    args.last.is_a?(Hash) ? args[0..-2] : args
  end

  def extract_opts_from_args(args)
    args.last.is_a?(Hash) ? args.last : {}
  end

  def instance_variable_for_attr(attr)
    :"@#{attr}"
  end

  def writer_method_for_attr(attr)
    :"#{attr}="
  end
end
