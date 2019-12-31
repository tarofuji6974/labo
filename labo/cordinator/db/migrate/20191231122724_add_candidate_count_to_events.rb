class AddCandidateCountToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :candidate_count, :text
  end
end
