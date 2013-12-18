class AddConfirmableToUser < ActiveRecord::Migration
  # See: https://github.com/plataformatec/devise/wiki/How-To%3a-Add-%3aconfirmable-to-Users
  # Note: You can't use change, as User.update_all with fail in the down migration
  def self.up
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_index :users, :confirmation_token, :unique => true
    User.update_all(:confirmed_at => Time.now)
  end

  def self.down
    remove_columns :users, :confirmation_token, :confirmed_at, :confirmation_sent_at
  end
end
