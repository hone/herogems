module RSpec
  module Helpers
    def run(cmd, options = {})
      expect_err  = options.delete(:expect_err)
      exitstatus = options.delete(:exitstatus)

      lib = File.expand_path('../../../lib', __FILE__)

      heroku_home_directory = "-r#{File.expand_path('../heroku_home_directory.rb', __FILE__)}"

      env = (options.delete(:env) || {}).map{|k,v| "#{k}='#{v}' "}.join
      args = options.map do |k,v|
        v == true ? " --#{k}" : " --#{k} #{v}" if v
      end.join

      cmd = "#{env}#{Gem.ruby} -I#{lib} #{heroku_home_directory} #{HEROKU_BIN} #{cmd}#{args}"

      if exitstatus
        sys_status(cmd)
      else
        sys_exec(cmd, expect_err){|i| yield i if block_given? }
      end
    end

    def sys_exec(cmd, expect_err = false)
      Open3.popen3(cmd.to_s) do |stdin, stdout, stderr|
        @in_p, @out_p, @err_p = stdin, stdout, stderr

        yield @in_p if block_given?
        @in_p.close

        @out = @out_p.read.to_s.strip
        @err = @err_p.read.to_s.strip
      end

      puts @err unless expect_err || @err.empty? || !$show_err
      @out
    end

    def sys_status
      @err = nil
      @out = %x{#{cmd}}.strip
      @exitstatus = $?.exitstatus  
    end

    def reset!
      @in_p, @out_p, @err_p = nil, nil, nil
      tmp_gems = "#{tmp_path}/gems"
      # Dir["#{tmp}/gems/*,*}"].each do |dir|
      #   FileUtils.rm_rf(dir)
      # end
      FileUtils.rm_rf(tmp_path)
      FileUtils.mkdir_p(tmp_path)
      FileUtils.mkdir_p("#{tmp_path}/.heroku/plugins")
      FileUtils.ln_s(File.expand_path("../../../", __FILE__), "#{tmp_path}/.heroku/plugins/herogems")

      ENV['RUBYOPT'] = nil
      ENV['BUNDLE_GEMFILE'] = nil
      ENV['GEM_PATH'] = [ENV['GEM_HOME'], tmp_gems].join(':')
      ENV['GEM_HOME'] = tmp_gems
    end

    def gem_install(gem_name)
      system("gem install #{plugin_gem_path(gem_name)} --ignore-dependencies --no-ri --no-rdoc > /dev/null")
    end
  end
end
