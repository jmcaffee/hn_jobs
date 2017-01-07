require "./hn_jobs/*"
require "cossack"
require "html"

# Example URL: https://news.ycombinator.com/item?id=13301832

module HnJobs
  class Main
      @id : String
      @cmd : String
      getter url
      getter id
      getter cmd

      def initialize(args)
          unless args.size > 0
              usage
              exit 1
          end

          @id = args[0]
          @url = "https://hacker-news.firebaseio.com"

          if args.size >= 2
              @cmd = args[1]
          else
              @cmd = ""
          end
      end

      def usage
          puts "Usage: hn_jobs <article_id>"
          puts
      end

      def client
          cossack = Cossack::Client.new(url) do |client|
              client.request_options.connect_timeout = 60.seconds
          end
      end

      def get_item(item_id)
          response = client.get("/v0/item/#{item_id}.json?print=pretty")
      end

      def get_article
          #response = client.get("/v0/item/#{id}.json?print=pretty")
          response = get_item(id)
          puts "Response status: #{response.status}"
          #puts "Response body: #{response.body}"

          Article.from_json(response.body)
      end

      def get_comment(comment_id)
        response = get_item(comment_id)
        Comment.from_json(response.body)
      end

      def dump_remotes(ids : Array(Int32))
        ids.each do |cid|
            #puts "CID: #{cid}"
            comment = get_comment(cid)
            remote = false
            if comment.text.includes?("REMOTE")
                remote = true
            elsif comment.text.includes?("remote")
                remote = true
            end

            if remote
                emit_unencoded_text comment.text
                puts
                puts "-"*40
                puts
            end
        end
      end

      def emit_unencoded_text(text)
          text = HTML.unescape(text)

          code_ticks = "\n```\n"
          blank_line = "\n\n"
          em = "*"

          text = text.gsub("<p>", blank_line)
          text = text.gsub("<pre><code>", code_ticks)
          text = text.gsub("</code></pre>", code_ticks)
          # FIXME: Convert anchor links to markdown links
          text = text.gsub("<i>", em)
          text = text.gsub("</i>", em)
          text = text.gsub("<em>", em)
          text = text.gsub("</em>", em)

          puts text
      end

      def execute
          if cmd == "dump"
              puts get_item(id).body
          else
            article = get_article
            puts "Title: #{article.title}"
            comment_ids = article.kids
            comment_count = comment_ids.size
            puts "Comment count: #{comment_count}"

            dump_remotes(comment_ids)
          end

          #comment = get_comment(comment_ids[1])
          #puts HTML.unescape(comment.text)
          # Suggested Regex:
          #\s*(?P<company>[^|]+?)\s*\|\s*(?P<title>[^|]+?)\s*\|\s*(?P<locations>[^|]+?)\s*(?:\|\s*(?P<attrs>.+))?$
          #
      end
  end
end

HnJobs::Main.new(ARGV).execute

