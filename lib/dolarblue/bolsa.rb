require 'dolarblue/xchange'

class Dolarblue
  # Class used to hold sell/buy values functionality for dollar "Official"
  class Bolsa < XChange
    # Override extract_values since dollar "tarjeta" only has a sell value
    #
    # @param doc [Nokogiri::HTML] the html document to extract values from
    def extract_values(doc)
      @sell = extract_val(doc, 'sell')
    end

    # Override buy_output since dollar "tarjeta" only has a sell value
    #
    # @return [String] formatted output buy exchange value, in this case n/a for not available
    def buy_output
      'n/a'
    end
  end
end
