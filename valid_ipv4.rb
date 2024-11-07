def valid_ipv4?(ip)
  return false unless ip.match?(/^\d+(\.\d+){3}$/)

  octets = ip.split('.')

  return false unless octets.size == 4

  octets.all? do |octet|
    octet.match?(/^\d+$/) && octet.to_i.between?(0, 255) && octet == octet.to_i.to_s
  end
end

