# frozen_string_literal: true

module Rakeman
  module Lib
    module Callable
      def call(*args, &block)
        new(*args, &block).call
      end
    end
  end
end
