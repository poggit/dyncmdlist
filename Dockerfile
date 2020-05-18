FROM pmmp/pocketmine-mp:latest

USER pocketmine
WORKDIR /pocketmine

RUN wget https://raw.githubusercontent.com/pmmp/DevTools/master/src/DevTools/ConsoleScript.php
ADD ./dyncmdlist ./dyncmdlist
RUN php -dphar.readonly=0 ConsoleScript.php --make dyncmdlist --relative dyncmdlist --out dyncmdlist.phar

USER root
RUN mkdir /input
USER pocketmine

ADD ./wrapper.sh ./wrapper.sh
CMD ./wrapper.sh
