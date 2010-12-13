# encoding: utf-8

class Array
  def pair array
    Hash.new.tap do |result|
      array.each_index do |index|
        result.store self[index], array[index]
      end
    end
  end
end
