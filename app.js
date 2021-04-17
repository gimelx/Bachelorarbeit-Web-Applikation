const path = require('path');

const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const errorController = require('./controllers/error')

app.set('view engine', 'ejs');
app.set('views', 'views');

const userRoutes = require('./routes/user');

app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, 'public')));

app.use(userRoutes);

app.use(errorController.get404);

app.listen(4000);