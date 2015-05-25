#
# Copyright 2015, Noah Kantrowitz
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/config'
require 'chef/log'
require 'chef/mixin/shell_out'
require 'chef/mixin/which'
require 'chef/provider'
require 'chef/resource/gem_package'
require 'poise'

require 'poise_ruby/resources/ruby_runtime'


module PoiseRuby
  module Resources
    # (see RubyGem::Resource)
    # @since 2.0.0
    module RubyGem
      # A `ruby_gem` resource to install Ruby gems.
      #
      # @provides ruby_gem
      # @action install
      # @action upgrade
      # @action remove
      # @action purge
      # @action reconfig
      # @example
      #   ruby_gem 'rack'
      class Resource < Chef::Resource::GemPackage
        include Poise(parent: true)
        provides(:ruby_gem)

        # @api private
        def initialize(name, run_context=nil)
          super
          @resource_name = :ruby_gem if @resource_name
          # Remove when all useful versions are using provider resolver.
          @provider = PoiseRuby::Resources::RubyGem::Provider if @provider
        end

        # @!attribute parent_ruby
        #   Parent ruby installation.
        #   @return [PoiseRuby::Resources::Ruby::Resource, nil]
        parent_attribute(:ruby, type: :ruby_runtime, optional: true)
        # @!attribute gem_binary
        #   Extend the default #gem_binary to use the parent Ruby by default.
        #   @return [String]
        attribute(:gem_binary, kind_of: String, default: lazy { parent_ruby && parent_ruby.gem_binary })

        # Nicer name for the DSL.
        alias_method :ruby, :parent_ruby
      end

      # The default provider for `ruby_gem`.
      #
      # @see Resource
      # @provides ruby_gem
      class Provider < Chef::Provider::Package::Rubygems
        include Poise
        provides(:ruby_gem)
      end
    end
  end
end