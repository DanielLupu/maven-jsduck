require 'jsduck/table'
require 'jsduck/short_params'
require 'jsduck/long_params'

module JsDuck

  class EventTable < Table
    def initialize(cls, formatter, cache={})
      super(cls, formatter, cache)
      @type = :event
      @id = @cls.full_name + "-events"
      @title = "Public Events"
      @column_title = "Event"
      @row_class = "event-row"
      @short_params = ShortParams.new
      @long_params = LongParams.new(@formatter)
    end

    def signature_suffix(item)
      " : " + @short_params.render(item[:params])
    end

    def extra_doc(item)
      [
        "<div class='mdetail-params'>",
        "<strong style='font-weight: normal;'>Listeners will be called with the following arguments:</strong>",
        @long_params.render(item[:params]),
        "</div>"
      ].join("\n")
    end
  end

end
