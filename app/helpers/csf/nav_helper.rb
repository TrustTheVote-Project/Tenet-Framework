module Csf
  module NavHelper

    def item_class(item)
      @navbar_item == item ? 'active' : nil
    end

  end
end
