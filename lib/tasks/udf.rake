namespace :udf do
  task :load => :environment do
    puts "Loading udf functions ..."
    files = Dir.entries('db/udf').select{|file| file['.sql']}
    if files.empty?
      puts "There is no udf function to load"
      else load_udfs(files)
    end
  end

  def load_udfs(files)
    cx = ActiveRecord::Base.connection
    # -- is it worth loading the list of known procedures?
    #result_set = cx.execute(
    #    "select proname,proargnames from pg_catalog.pg_namespace n join pg_catalog.pg_proc p on pronamespace = n.oid where nspname='public'")
    #known_procedures = result_set.column_values(0)
    files.each {|file|
      proc_name = file[0..-5] # remove '.sql' extension
      puts "  loading procedure #{proc_name} -- [#{file}]"
      proc = File.open("db/udf/#{file}", 'rb').read
      # -- don't 'drop' the function, we can just 'create or replace' it
      #if known_procedures.include?(proc_name)
      #  # must also include the arguments to drop the udf
      #  cx.execute("DROP FUNCTION IF EXISTS #{proc_name}")
      #end
      cx.execute(proc)
    }
  end
end