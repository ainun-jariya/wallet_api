# frozen_string_literal: true

# parents of all models
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def soft_destroy
    update(deleted_at: Time.now)
  end
end
