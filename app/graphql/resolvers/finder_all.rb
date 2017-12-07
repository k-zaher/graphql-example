class Resolvers::FinderAll < GraphQL::Function
  attr_reader :type

  def initialize(model_class:, type:)
    @model_class = model_class
    @type = type
  end

  def call(obj, args, ctx)
    @model_class.all
  end
end
