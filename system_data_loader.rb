module SystemDataLoader
  def secret_key
    read_line_from_file('secret_key.txt')
  end
  
  def pin_num
    read_line_from_file('pin_num.txt').to_i
  end

  def box_id
    read_line_from_file('box_id.txt').to_i
  end

  private

  def read_line_from_file(file_name)
    file = File.open(file_name)

    file_data = file.read

    file.close

    file_data
  end
end
