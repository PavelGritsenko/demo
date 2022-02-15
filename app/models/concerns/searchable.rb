module Searchable
  extend ActiveSupport::Concern
 
  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    
    # define which fields will be sent to ES
    def as_indexed_json(_options = {})
      as_json(only: %i[title content])
    end
 
    # specify to ES how we want to index our data
    settings settings_attributes do
      mappings dynamic: false do
        indexes :title, type: :string, analyzer: :autocomplete
        indexes :content, type: :text, analyzer: :autocomplete
      end
    end
 
    def self.search(query)
      __elasticsearch__.search(
        {
          query: {
            multi_match: {
              query: query,
              fields: ['title', 'text']
            }
          },
          highlight: {
            pre_tags: ['<em>'],
            post_tags: ['</em>'],
            fields: {
              title: {},
              text: {}
            }
          }
        }
      )
    end
  end
 
  # define a custom analyzer
  class_methods do
    def settings_attributes
      {
        index: {
          analysis: {
            analyzer: {
              # define custom analyzer with name autocomplete
              autocomplete: {
                # type should be custom for custom analyzers
                type: :custom,
                # use standard tokenizer
                tokenizer: :standard,
                # apply two token filters
                # autocomplete filter is a custom filter that we defined above
                filter: %i[lowercase autocomplete]
              }
            },
            filter: {
              # define custom token filter with name autocomplete
              autocomplete: {
                type: :edge_ngram, # edge_ngram tokenizer divides the text into smaller parts (grams)
                min_gram: 2,
                max_gram: 25
              }
            }
          }
        }
      }
    end
  end
end