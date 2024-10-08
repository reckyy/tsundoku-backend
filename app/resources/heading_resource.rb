# frozen_string_literal: true

class HeadingResource < BaseResource
  attributes :id, :number, :title

  one :memo, resource: MemoResource
end
