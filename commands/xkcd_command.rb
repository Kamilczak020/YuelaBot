module Commands
  class XkcdCommand
    class << self
      include Discordrb::Webhooks
      def name
        :xkcd
      end

      def attributes
        {
          max_args: 1,
          usage: "xkcd <id>",
          description: "Returns the given XKCD comic, or the latest if no ID is specified"
        }
      end

      def command(event, id="")
        return if event.from_bot?
        begin
          resp = open("http://xkcd.com/#{id}/info.0.json").read
          json = JSON.parse(resp)
          embed = Embed.new(
            title: json['title'],
            timestamp: Time.parse("#{json['year']}-#{json['month']}-#{json['day']}"),
            image: EmbedImage.new(url: json['img']),
            description: json['alt']
          )
          event.respond nil, nil, embed
        rescue OpenURI::HTTPError
          event.respond "No XKCD found for #{id}"
        end
      end
    end
  end
end