# frozen_string_literal: true

module Rakeman
  class ApplicationService
    def self.call(*args, &block)
      new(*args).call(&block)
    end

    private

    def success!(**args)
      OpenStruct.new(success?: true, failure?: false, **args)
    end

    def failure!(**args)
      OpenStruct.new(success?: false, failure?: true, **args)
    end
  end
end
