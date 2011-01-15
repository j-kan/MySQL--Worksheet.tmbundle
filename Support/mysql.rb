#!/usr/bin/env ruby -wKU

MYSQL_CMD = "#{ENV['MYSQL_DIR']}/bin/mysql -u#{ENV['MYSQL_USER']}" + (ENV['MYSQL_PW'].empty? ? "" : " -p#{ENV['MYSQL_PW']}")


def query(q)
  `echo "#{q}" | #{MYSQL_CMD}`.split(/\n/)
end  
  
def formatted_query(q)
  `echo "#{q}" | #{MYSQL_CMD} -D#{schema_name()} -t`
end 
  
def databases()
  query("show databases").drop(1)
end  

def contains_database_name(name)
  databases().find do |db|
    name =~ /\b#{db}\b/
  end
end

def schema_name()
  contains_database_name(ENV['TM_FILENAME']) || ENV['MYSQL_DEFAULT_DB']
end

def table_names()
  query("show tables from #{schema_name()}").drop(1)
end

