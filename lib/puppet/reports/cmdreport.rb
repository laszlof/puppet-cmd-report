require 'puppet'
require 'tempfile'
require 'yaml'

Puppet::Reports.register_report(:cmdreport) do
  @configfile = File.join([File.dirname(Puppet.settings[:config]), "cmdreport.yaml"])
  raise(Puppet::ParseError, "Cmdreport config file #{@configfile} unreadable!") unless File.exists?(@configfile)
  config = YAML.load_file(@configfile)
  if config.key?('cmd') then
    CMD = config['cmd']
  else
    raise(Puppet::ParseError, 'Missing cmd from cmdreport.xml!')
  end
  if config.key?('replace_char') then
    REPLACE = config['replace_char']
  else
    REPLACE = '%s'
  end

  desc <<-DESC
Send reports to command line script
DESC

  def process
    fp = Tempfile.new('puppet-nw')
    begin
      fp.write(self.to_yaml)
      cmd = CMD.gsub(REPLACE, fp.path)
      ret = system(cmd)
    ensure
      fp.close
      fp.unlink
    end
  end
end
