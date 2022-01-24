import express from 'express';

const app = express();
const port = 3000;

const logPath = (req, res, next) => {
  console.log('Request made to path:', req.path)

  next()
}

app.get('/', logPath, (req, res) => {
  res.json({ success: true });
});

app.listen(port, () => {
  return console.log(`Express is listening on port: ${port}`);
});