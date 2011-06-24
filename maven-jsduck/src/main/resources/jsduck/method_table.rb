require 'jsduck/table'
require 'jsduck/short_params'
require 'jsduck/long_params'

module JsDuck

  class MethodTable < Table
    def initialize(cls, formatter, cache={})
      super(cls, formatter, cache)
      @type = :method
      @id = @cls.full_name + "-methods"
      @title = "Public Methods"
      @column_title = "Method"
      @row_class = "method-row"
      @short_params = ShortParams.new
      @long_params = LongParams.new(@formatter)
    end

    def signature_suffix(item)
      @short_params.render(item[:params]) + " : " + item[:return][:type]
    end

    def extra_doc(item)
      [
        "<div class='mdetail-params'>",
        "<strong>Parameters:</strong>",
        @long_params.render(item[:params]),
        "<strong>Returns:</strong>",
        render_return(item),
        "</div>"
      ].join("\n")
    end

    def render_return(item)
      type = @formatter.replace(item[:return][:type])
      doc = @formatter.format(item[:return][:doc])
      if type == "void" && doc.length == 0
        "<ul><li>void</li></ul>"
      else
        "<ul><li><code>#{type}</code><div class='sub-desc'>#{doc}</div></li></ul>"
      end
    end
  end

end
