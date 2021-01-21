if Rails.env.development?
  RailsERD.load_tasks

  module ERDGraph
    class Migration
      def self.update_model
        Zeitwerk::Loader.eager_load_all
        Rake::Task['erd'].invoke
      end
    end
  end
end