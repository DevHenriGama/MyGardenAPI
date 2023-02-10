# MyGardenAPI
Primeira versão MyGardenAPI - cli

MyGarden e uma API CLI para gerenciar “nos” de bomba de água  para jardim. Com MyGarden você consegue adicionar quantos “nos” quiser e programá-los para ligar no horário desejado e o tempo que ficara ligado. E uma solução simples porem pode ajudar pessoas que não tem muito tempo para cuidar do seu jardim ou da suas plantações. Os Nos podem ser usados com microcontroladores que conseguem acessar alguma rede Wi-Fi ou Cabeada. No protótipo eu utilizei um Esp8266 ligado a uma válvula elétrica ,e ele tinha um id único que busca na API os seus horários e armazenava na memoria  , e quando chegasse a hora ele ligava a válvula.

## Tecnologia
Delphi , Arduino, Restdataware.

## End-Points

* GET	/status
* POST 	/new?sector=0&time=23:00&date=12/01&duration=2
* POST 	/edit?id=0&sector=0&time=23:00&date=12/01&duration=2
* DELETE	/delete?id=0
* GET 	/node?id=0

### Preview:
![image](https://user-images.githubusercontent.com/101137965/218152967-0b6a4dd3-ce36-4b10-a493-79bf0552509c.png)
