module Commands
  class YoutubeCommand
    class << self
      def name
        :youtube
      end

      def attributes
        {
            min_args: 1,
            description: "Searches youtube for a video",
            usage: "youtube [query]",
            aliases: [:yt]
        }
      end

      def command(_, *args)
        return if event.from_bot?

        query = args.join(' ')
        service = Google::Apis::YoutubeV3::YouTubeService.new
        service.key = ENV['google']
        response = service.list_searches('snippet', q: query)
        video = response.items.first
        if video
          "https://www.youtube.com/watch?v=#{video.id.video_id}"
        else
          "No results found"
        end
      end
    end
  end
end