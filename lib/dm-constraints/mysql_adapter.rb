module DataMapper
  module Constraints
    module MysqlAdapter
      module SQL

        def destroy_constraints_statements(repository_name, model)
          model.many_to_one_relationships.map do |relationship|
            foreign_table = relationship.parent_model.storage_name(repository_name)
            "ALTER TABLE #{quote_table_name(model.storage_name(repository_name))} 
             DROP FOREIGN KEY #{relationship.name}_fk"
          end
        end

      end
    end
  end
end