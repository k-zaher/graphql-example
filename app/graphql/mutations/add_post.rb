Mutations::AddPost = GraphQL::Relay::Mutation.define do
  name "AddPost"

  # Accessible from `inputs` in the resolve function:
  input_field :userId,  !types.ID
  input_field :title,   !types.String
  input_field :content, !types.String

  # The result has access to these fields,
  # resolve must return a hash with these keys.
  # On the client-side this would be configured
  # as RANGE_ADD mutation, so our returned fields
  # must conform to that API.
  return_field :user, Types::UserType
  return_field :postsConnection, Types::PostType.connection_type
  return_field :newPostEdge, Types::PostType.edge_type

  # The resolve proc is where you alter the system state.
  resolve ->(object, inputs, ctx) {
    user = User.find(inputs[:userId])
    posts = user.posts
    new_post = posts.build(user_id: inputs[:userId],
                           title: inputs[:title],
                           content: inputs[:content])
    new_post.save!

    # Use this helper to create the response that a
    # client-side RANGE_ADD mutation would expect.
    range_add = GraphQL::Relay::RangeAdd.new(
      parent: user,
      collection: posts,
      item: new_post,
      context: ctx,
    )

    response = {
      user: user,
      postsConnection: range_add.connection,
      newPostEdge: range_add.edge,
    }
  }
end
