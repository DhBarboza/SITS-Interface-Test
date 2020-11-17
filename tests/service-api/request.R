library(httr)
g <- GET("http://127.0.0.1:6370")
g

status_code(g)

headers(g)

str(content(g))

r <- GET("http://127.0.0.1:6370//clustering/som/obj")
r

test <- GET("http://127.0.0.1:6370/clustering/som/obj", query = list(xdim = 1,
                                                                      ydim = 1,
                                                                      rlen = 1,
                                                                      alpha = 0.5))
test

url_test <- modify_url(url = "http://127.0.0.1:6370/", # replace with the door that rotates your API
                       path = "clustering/som/obj",
                       query = list(xdim = 1, ydim = 1))

requisition <- POST(url = url_test, body = iris, encode = "json")

k <- unserialize(content(requisition, as = "raw"))

k
