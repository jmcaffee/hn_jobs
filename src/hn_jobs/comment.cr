require "json"

module HnJobs
    class Comment
        JSON.mapping(
            deleted: { type: Bool,
                  key: "deleted",
                  #nilable => false,
                  default: false},
            by: { type: String,
                  key: "by",
                  #nilable => false,
                  default: ""},
            id: Int32,
            parent: Int32,
            text: { type: String,
                  key: "text",
                  #nilable => false,
                  default: ""},
            time: Int64,
            type: String
        )
    end
end
