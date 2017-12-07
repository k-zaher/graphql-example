Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.
  field :userAll, !types[Types::UserType], function: Resolvers::FinderAll.new(model_class: User, type: Types::UserType)
  field :userOne, function: Resolvers::FinderOne.new(model_class: User, type: Types::UserType)
  field :postOne, function: Resolvers::FinderOne.new(model_class: Post, type: Types::PostType)
  field :node, GraphQL::Relay::Node.field
  field :nodes, GraphQL::Relay::Node.plural_field
end
