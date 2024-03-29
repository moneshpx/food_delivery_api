class AddAdditionalInformationToAddress < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :additional_information, :string
  end
end
