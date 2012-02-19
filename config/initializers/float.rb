class Float
  #定义float的保留位数方法
  def roundf(places)
    temp = self.to_s.length
    sprintf("%#{temp}.#{places}f",self).to_f
  end
end
