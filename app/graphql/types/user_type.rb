Types::UserType = GraphQL::ObjectType.define do
  name "User"

  implements GraphQL::Relay::Node.interface

  global_id_field :id

  field :name, types.String
  field :age, types.Int
  connection :posts, Types::PostType.connection_type
end
