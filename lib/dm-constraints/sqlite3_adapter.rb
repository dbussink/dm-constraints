module DataMapper
  module Constraints
    module Sqlite3
      module SQL
        def create_table_statement(repository, model)
          p "HERE"
          stmt = super
          p stmt
          stmt
        end
      end
    end
  end
end