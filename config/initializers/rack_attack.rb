# frozen_string_literal: true

class Rack::Attack
  (1..5).each do |level|
    throttle("posts/ip/#{level}", limit: (20 * level), period: (8 ** level).seconds) do |req|
      req.ip if req.post?
    end
  end

  throttle('req/ip', limit: 300, period: 5.minutes, &:ip)

  blocklist('fail2ban') do |req|
    Fail2Ban.filter(req.ip.to_s, maxretry: 3, findtime: 10.minutes, bantime: 24.hours) do
      CGI.unescape(req.query_string).include?('/etc/passwd') ||
        req.path.include?('/etc/passwd') ||
        req.path.include?('wp-admin') ||
        req.path.include?('wp-login')
    end
  end
end
