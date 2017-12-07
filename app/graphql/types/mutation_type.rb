Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :addPost, field: Mutations::AddPost.field
end
