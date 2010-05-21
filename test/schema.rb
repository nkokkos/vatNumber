ActiveRecord::Schema.define(:version => 0) do
  create_table :people, :force => true do |t|
    t.column "name", :string
	t.column "vatnumber", :string
  end
end