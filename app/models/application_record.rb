# frozen_string_literal: true

# parents of all models
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  default_scope { where(deleted_at: nil) }

  def soft_destroy
    update(deleted_at: Time.now)
  end
end
