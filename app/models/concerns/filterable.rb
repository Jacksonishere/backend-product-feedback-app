module Filterable
  extend ActiveSupport::Concern

  class_methods do
    def filter(filter_params)
      results = where(nil)
      filter_params.each do |key, value|
        results = results.public_send("filter_by_#{key}", value) if value.present? && value != 'all'
      end
      results
    end 
  end
end