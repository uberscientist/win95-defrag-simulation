connect = require 'connect'

app = connect()
app.use connect.static 'static'
app.listen(8008)
