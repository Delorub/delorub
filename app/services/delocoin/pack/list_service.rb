class Delocoin::Pack::ListService
  def perform
    all.map do |e|

    end
  end

  private

    def all
      @_all ||= Delocoin::Pack.order('amount ASC').all
    end

    def current_step
      @_current_step ||= Delocoin::Step::CurrentService.new.perform
    end
end
