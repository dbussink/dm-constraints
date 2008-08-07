module DataMapper
  module Constraints
    module MysqlAdapter
      module SQL

        def destroy_foreign_key_constraints_statements(repository, model)
          repository_name = repository.name

          model.many_to_one_relationships.map do |relationship|
            foreign_table = relationship.parent_model.storage_name(repository_name)
            "ALTER TABLE #{quote_table_name(model.storage_name(repository_name))} 
             DROP FOREIGN KEY #{foreign_table}_fk"
          end
        end

      end
    end
  end
end