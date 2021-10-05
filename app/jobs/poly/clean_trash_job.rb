module Poly
  class CleanTrashJob < ApplicationJob
    queue_as :default

    # Delete the parent record and then remove the trash item
    def perform(trash)
      trash.trashable.destroy
      trash.destroy
    end
  end
end
