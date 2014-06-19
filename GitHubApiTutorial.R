library(httr)
library(jsonlite)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications
#    Insert your values below - if secret is omitted, it will look it up in
#    the GITHUB_CONSUMER_SECRET environmental variable.
#
#    Use http://localhost:1410 as the callback url
myapp <- oauth_app("github", key = "63ae31c9e8fb54ffa833", 
                   secret = "2302668027b9ddc9a1dcad893fe4de30664fb9c5")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
req <- GET("https://api.github.com/users/jtleek/repos", 
           config(token = github_token))
stop_for_status(req)
content(req)
json1 <- content(req)
json2 <- jsonlite::fromJSON(toJSON(json1))
