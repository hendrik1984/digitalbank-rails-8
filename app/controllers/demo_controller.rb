class DemoController < ApplicationController
  def index
  end

  def update
    render turbo_stream: turbo_stream.replace(
      "message",
      partial: "demo/message"
    )
  end
end
