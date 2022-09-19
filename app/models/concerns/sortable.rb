module Sortable
  extend ActiveSupport::Concern

  class_methods do
    def sort_by(sort_by_params)
      results = where(nil)
      sort_by_params.each do |key, order|
        results = results.public_send("sort_by_#{key}", order) if order.present?
      end
      results
    end 
  end
end