# frozen_string_literal: true

# Adds callable interface to objects
module Callable
  def call(...)
    new(...).call
  end
end
