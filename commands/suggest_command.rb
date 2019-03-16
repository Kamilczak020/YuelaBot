module Commands
  class SuggestCommand
    class << self
      def name
        :suggest
      end

      def attributes
        {
            description: "Suggest a feature for the bot",
            usage: "suggest something"
        }
      end

      def command(e, *terms)
        return if e.from_bot?

        suggestion = terms.join(' ')
        client = Octokit::Client.new(login: ENV['github_login'], password: ENV['github_password'])
        client.create_issue('horizonshadow/yuelabot', suggestion)
        e.respond "Suggestion added!"
      end
    end
  end
end