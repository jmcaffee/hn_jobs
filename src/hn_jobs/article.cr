require "json"

module HnJobs
    class Article
        JSON.mapping(
            by: String,
            descendants: Int32,
            id: Int32,
            kids: Array(Int32),
            score: Int32,
            text: String,
            time: Int64,
            title: String,
            type: String
        )
    end
end

