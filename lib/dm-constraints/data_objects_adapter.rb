module DataMapper
  module Constraints
    module DataObjectsAdapter
      module SQL
        def create_foreign_key_constraints_statements(repository, model)
          repository_name = repository.name

          model.many_to_one_relationships.map do |relationship|
            parent        = relationship.parent_model
            foreign_table = parent.storage_name(repository_name)
            foreign_keys  = parent.key.map { |key| property_to_column_name(parent.repository, key, false) } * ', '
            keys          = relationship.child_key.map { |key| property_to_column_name(repository, key, false) } * ', '
            "ALTER TABLE #{quote_table_name(model.storage_name(repository_name))}
             ADD CONSTRAINT #{foreign_table}_fk FOREIGN KEY (#{keys}) REFERENCES #{foreign_table} (#{foreign_keys})"
          end
        end

        def destroy_foreign_key_constraints_statements(repository, model)
          repository_name = repository.name

          model.many_to_one_relationships.map do |relationship|
            foreign_table = relationship.parent_model.storage_name(repository_name)
            "ALTER TABLE #{quote_table_name(model.storage_name(repository_name))} 
             DROP CONSTRAINT #{foreign_table}_fk"
          end
        end

      end

      module Migration

        def self.included(adapter)
          adapter.after :create_model_storage, :create_foreign_key_constraints
          adapter.after :upgrade_model_storage, :create_foreign_key_constraints

          adapter.before :destroy_model_storage, :destroy_foreign_key_constraints
          adapter.before :upgrade_model_storage, :destroy_foreign_key_constraints
        end

        def create_foreign_key_constraints(retval, repository, model)
          if storage_exists?(model.storage_name(repository.name))
            queries = create_foreign_key_constraints_statements(repository, model)
            queries.each {|q| execute(q) }
          end
        end

        def destroy_foreign_key_constraints(repository, model)
          if storage_exists?(model.storage_name(repository.name))
            queries = destroy_foreign_key_constraints_statements(repository, model)
            queries.each {|q| execute(q) }
          end
        end
      end
    end
  end
end