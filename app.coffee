express = require 'express'
app = express()
Poet = require 'poet'
poet = Poet app, ->
    posts: './_posts'
    postsPerPage: 5
    metaFormat: 'json'

poet.init().then( ->
  poet.clearCache()
)

app.set('view engine', 'jade')
app.set('views', __dirname + '/views')
app.use(express.static(__dirname + '/public'))
 
poet.addRoute '/post/:post', (req, res)->
  post = poet.helpers.getPost req.params.post
  if post
    res.render 'post',
      post: post
  else
    res.send(404)

app.get '/', (req, res) ->
  res.render 'index'

app.listen 3000

