class Api::V1::UsersSerializer < ActiveModel::Serializer
  # attributes :id
  attributes :id, :email, :created_at, :updated_at
end