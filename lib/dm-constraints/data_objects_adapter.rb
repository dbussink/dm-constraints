module DataMapper
  module Constraints
    module DataObjectsAdapter
      module SQL
        def create_foreign_key_constraints_statement(repository, model)
          repository_name = repository.name

          constraints = model.many_to_one_relationships.map do |relationship|
            parent        = relationship.parent_model
            foreign_table = parent.storage_name(repository_name)
            foreign_keys  = parent.key.map { |key| property_to_column_name(parent.repository, key, false) } * ', '
            keys          = relationship.child_key.map { |key| property_to_column_name(repository, key, false) } * ', '
            "CONSTRAINT #{foreign_table}_fk FOREIGN KEY (#{keys}) REFERENCES #{foreign_table} (#{foreign_keys})"
          end * ', '

          "ALTER TABLE #{quote_table_name(model.storage_name(repository_name))} ADD #{constraints}" unless constraints.empty?
        end

        def destroy_foreign_key_constraints_statement(repository, model)
          repository_name = repository.name

          model.relationships
          constraints = model.many_to_one_relationships.map do |relationship|
            foreign_table = relationship.parent_model.storage_name(repository_name)
            "CONSTRAINT #{foreign_table}_fk"
          end * ', '

          "ALTER TABLE #{quote_table_name(model.storage_name(repository_name))} DROP #{constraints}" unless constraints.empty?
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
            query = create_foreign_key_constraints_statement(repository, model)
            execute(query) if query
          end
        end

        def destroy_foreign_key_constraints(repository, model)
          if storage_exists?(model.storage_name(repository.name))
            query = destroy_foreign_key_constraints_statement(repository, model)
            #execute(query) if query
          end
        end
      end
    end
  end
end