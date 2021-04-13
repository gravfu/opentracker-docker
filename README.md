# opentracker-docker

Using this repo, you can have an optimized version of opentracker with docker (Multi Stage Build).

Open Tracker allow anyone to create his own bittorrent tracker.


## Runing the container:
```bash
docker run -d -p 6969:6969/udp -p 6969:6969 vince52fr/opentracker-docker 
```
