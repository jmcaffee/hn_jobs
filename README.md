# hn_jobs

Search/Filter a Hacker News 'Who is hiring' post given a post ID.

This simple app is used as a POC for the Crystal language - my first simple
Crystal application.

## Installation

Clone the repo

    git clone https://github.com/jmcaffee/hn_jobs.git

Install dependencies

    cd hn_jobs
    crystal deps

Build the app

    crystal build --release src/hn_jobs.cr

## Usage

Run the generated executable

    ./hn_jobs

    $ Usage: hn_jobs <article_id>

Provide the article ID of the 'Who's hiring HN thread' and the app will output
a list of comments that contain `(REMOTE|remote)`

Example URL: `https://news.ycombinator.com/item?id=13301832`

Command: `./hn_jobs 13301832`


## Development

Tests can be run with `crystal`:

    crystal spec

## Contributing

1. Fork it ( https://github.com/jmcaffee/hn_jobs/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [jmcaffee](https://github.com/jmcaffee) Jeff McAffee - creator, maintainer
