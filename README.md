# Database/SQL brainhuddle

If you want to play all the stuff with me. Please checkout this repo or unpack the attached zip file.


## Download or checkout the code

### From github.com

```
git clone https://github.com/vogelwarte/sql_brainhuddle 
```

### unzip from Attachment
Name is *sql_brainhuddle-main.zip*


## Recommended Installed Software

- RStudio
- [DBeavber](https://dbeaver.io/download/)


## .Renviron
Please copy and paste this content into the *.Renviron* file in your home or working directory (`./database/sql_r/.Renviron`).

```
DATABASE_HOST=dbspatialdata_projects
DATABASE_PORT=5432
DATABASE_NAME=playground
DATABASE_USER=sql_brainhuddle
DATABASE_PASSWORD=<tbd />
```


### for advanced users


You have to install docker on windows:

[Install Docker](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-win-amd64)

```
docker run --name devdb -e POSTGRES_PASSWORD=postgres -p 127.0.0.1:5432:5432 -d postgis/postgis
```

Run the presentation in a developing mode:

Download the docker image
```
docker pull marpteam/marp-cli
````

Run marp as service and open a browser (chromebased) on http://localhost:8080/

```
docker run --rm --init -v $PWD:/home/marp/app -e LANG=en_GB.UTF-8 -p 8080:8080 -p 37717:37717 marpteam/marp-cli -s .
```