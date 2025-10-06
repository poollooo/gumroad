# frozen_string_literal: true

module StructuredDataHelper
  def book_structured_data(product)
    files_with_isbn = product.alive_product_files.select(&:isbn)
    return unless files_with_isbn.any?

    {
      "@context": "https://schema.org",
      "@type": "Book",
      "name": product.name,
      "description": strip_tags(product.description).truncate(200),
      "url": product.long_url,
      "author": {
        "@type": "Person",
        "name": product.user.name
      },
      "workExample": files_with_isbn.map do |file|
        {
          "@type": "Book",
          "bookFormat": "http://schema.org/EBook",
          "name": file.name_displayable,
          "isbn": file.isbn
        }
      end,
    }.to_json.html_safe
  end
end
