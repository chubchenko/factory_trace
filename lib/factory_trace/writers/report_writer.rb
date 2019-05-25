module FactoryTrace
  module Writers
    class ReportWriter < Writer
      COLORS = {
        blue: "\e[34m",
        green: "\e[32m",
        red: "\e[31m"
      }.freeze

      # @param [Array<Hash>] results
      def write(results)
        total_color = results.size == 2 ? :green : :red

        results.each do |result|
          configuration.out.puts(convert(result, total_color: total_color))
        end
      end

      private

      # @param [Hash<Symbol, Object>] result
      # @param [Symbol] total_color
      def convert(result, total_color:)
        case
        when result[:value]
          colorize(total_color, "total number of unique #{result[:code]} factories & traits: #{result[:value]}")
        when result[:factory_name] && result[:trait_name]
          "#{result[:code]} trait #{colorize(:blue, result[:trait_name])} of factory #{colorize(:blue, result[:factory_name])}"
        when result[:factory_name]
          "#{result[:code]} factory #{colorize(:blue, result[:factory_name])}"
        else
          "#{result[:code]} global trait #{colorize(:blue, result[:trait_name])}"
        end
      end

      def colorize(color, msg)
        return msg unless configuration.color

        "#{COLORS[color]}#{msg}\e[0m"
      end
    end
  end
end
