git pull
docker build -t instatekweb .
docker run -d -p 80:80 --name instatek instatekweb
