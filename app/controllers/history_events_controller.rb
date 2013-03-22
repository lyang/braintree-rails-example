class HistoryEventsController < ApplicationController
  def index
    @events = HistoryEvent.order('created_at desc')
  end
end
