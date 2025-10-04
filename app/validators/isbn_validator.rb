# frozen_string_literal: true

class IsbnValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    # Remove hyphens and spaces for validation
    normalized_isbn = value.to_s.gsub(/[-\s]/, "")

    # Check if it's ISBN-10 or ISBN-13
    case normalized_isbn
    when /\A\d{9}[\dXx]\z/
      validate_isbn10(record, attribute, normalized_isbn)
    when /\A\d{13}\z/
      validate_isbn13(record, attribute, normalized_isbn)
    else
      record.errors.add(attribute, "doesn't appear to be a valid ISBN. Please check the number and try again")
    end
  end

  private

  def validate_isbn10(record, attribute, isbn)
    # ISBN-10 checksum validation using modulo 11
    digits = isbn[0..8].chars.map(&:to_i)
    check_digit = isbn[9].upcase == 'X' ? 10 : isbn[9].to_i

    sum = 0
    digits.each_with_index do |digit, index|
      sum += digit * (10 - index)
    end
    sum += check_digit

    if sum % 11 != 0
      record.errors.add(attribute, "doesn't appear to be a valid ISBN. Please check the number and try again")
    end
  end

  def validate_isbn13(record, attribute, isbn)
    # ISBN-13 must start with 978 or 979
    unless isbn.start_with?('978', '979')
      record.errors.add(attribute, "must start with 978 or 979 for ISBN-13 format")
      return
    end

    # ISBN-13 checksum validation using modulo 10
    digits = isbn.chars.map(&:to_i)
    sum = 0

    digits[0..11].each_with_index do |digit, index|
      multiplier = index.even? ? 1 : 3
      sum += digit * multiplier
    end

    check_digit = (10 - (sum % 10)) % 10

    if check_digit != digits[12]
      record.errors.add(attribute, "doesn't appear to be a valid ISBN. Please check the number and try again")
    end
  end
end
