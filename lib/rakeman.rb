# frozen_string_literal: true

require 'rakeman/engine'
require 'rakeman/configuration'

module Rakeman
  module_function

  def configure
    yield(configuration)
  end

  def method_missing(method_name, *arguments, &block)
    return super unless configuration.respond_to?(method_name)

    configuration.public_send(method_name, *arguments, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    configuration.respond_to?(method_name) || super
  end

  def configuration
    ::Rakeman::Configuration.instance
  end

  private_class_method :configuration
end
