module Poly
  class ApplicationSerializer < ActiveModelSerializers::Model
    attributes :id, :created_at, :updated_at
  end
end
