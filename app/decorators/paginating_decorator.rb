class PaginatingDecorator < Draper::CollectionDecorator
  delegate :current_page, :offset, :per_page, :total_entries, :total_pages
end
