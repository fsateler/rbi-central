# frozen_string_literal: true

module RBICentral
  RBIS_PATH = "rbi/annotations"

  class RBIValidator
    extend CLI
    include CLI

    def self.validate_files!(repo_index, files)
      success = true

      files.each do |file|
        validator = self.new(repo_index, file)
        unless validator.validate_file!
          $stderr.puts("")
          success = false
        end
      end

      exit(1) unless success

      success("\nNo errors, good job!")
    end

    def initialize(repo_index, rbi_file)
      @repo_index = repo_index
      @rbi_file = rbi_file
      @gem_name = File.basename(rbi_file, ".rbi")
    end

    def validate_file!; end
  end

  def self.rbi_files
    ARGV.empty? ? Dir.glob("./#{RBIS_PATH}/*.rbi") : ARGV
  end
end
