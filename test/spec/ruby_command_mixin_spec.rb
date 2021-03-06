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

require 'spec_helper'

describe PoiseRuby::RubyCommandMixin do
  describe PoiseRuby::RubyCommandMixin::Resource do
    resource(:poise_test) do
      include described_class
    end
    subject { resource(:poise_test).new('test', nil) }

    it { is_expected.to respond_to :parent_ruby }
    it { is_expected.to respond_to :ruby }
    it { is_expected.to respond_to :gem_binary }
    it { expect(subject.respond_to?(:ruby_from_parent, true)).to be true }
  end # /describe PoiseRuby::RubyCommandMixin::Resource

  describe PoiseRuby::RubyCommandMixin::Provider do
  end # /describe PoiseRuby::RubyCommandMixin::Provider
end
