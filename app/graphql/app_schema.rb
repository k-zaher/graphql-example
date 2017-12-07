AppSchema = GraphQL::Schema.define do
  mutation(Types::MutationType)
  query(Types::QueryType)

  resolve_type ->(type, obj, ctx) {
    case obj
    when Post
      Types::PostType
    when User
      Types::UserType
    else
      raise("Unexpected object: #{obj}")
    end
  }

  # Create UUIDs by joining the type name & ID, then base64-encoding it
  id_from_object ->(object, type_definition, query_ctx) {
    GraphQL::Schema::UniqueWithinType.encode(type_definition.name, object.id)
  }

  object_from_id ->(id, query_ctx) {
    type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
    Object.const_get(type_name).find(item_id)
  }
end
