module RestEasy
  module Pagination
    extend ActiveSupport::Concern

    PER_PAGE = 100

    protected

    def collection_chain
      super.send(pagination_method, page).send(per_page_method, per_page)
    end

    def page
      params[page_param]
    end

    def per_page
      params[per_page_param] || PER_PAGE
    end

    def pagination_method
      :page
    end

    def page_param
      :page
    end

    def per_page_param
      :per
    end

    def per_page_method
      :per
    end

  end
end
