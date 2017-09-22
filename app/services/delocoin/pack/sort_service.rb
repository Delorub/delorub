class Delocoin::Pack::SortService
  def perform
    ActiveRecord::Base.transaction do
      number = 1

      all.map do |pack|
        pack.update_column(:number, number)
        number += 1
      end
    end
  end

  private

    def all
      @_all ||= Delocoin::Pack.order('cost ASC').all
    end
end
