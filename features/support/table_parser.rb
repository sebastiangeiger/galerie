class TableParser
  def initialize(page, selector)
    @page = page
    @table = @page.first(selector)
  end
  def find_row(hash={})
    raise "Only supporting one attribute for now" unless hash.size == 1
    key = hash.keys.first
    value = hash.values.first
    rows = @table.all("td[#{column_number_for(key)}]").
      select{|cell| cell.text == value}
    raise "Expected to find 1 row, found #{rows.size}." unless rows.size == 1
    @row = @page.first(:xpath, "#{rows.first.path}/..") #.parent didn't work correctly
    self
  end
  def text
    @cell.text
  end
  def find_column(column_name)
    column_number = column_number_for(column_name)
    @cell = @row.first("td[#{column_number}]")
    self
  end

  private
  def column_number_for(column_name)
    columns = @table.all('th').
      select{|cell| cell.text.downcase.to_sym == column_name.to_sym}
    raise "Expected to find 1 column, found #{columns.size}." unless columns.size == 1
    columns.first.path.match(/th\[(\d+)\]$/)[1]
  end
end

