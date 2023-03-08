<?php

require 'ApiCore.php';
$core = new ApiCore();
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);

$core->isBlocked();

$headers = array_change_key_case(getallheaders());
if($_SERVER['REQUEST_METHOD'] != 'OPTIONS') {
    if(isset($data['serial'],$data['ip'], $data['port'], $headers['authorization'])) {
        $findToken = R::findone('accounts','auth_token = ?', [$headers['authorization']]);
        if($findToken) {
            if($findToken->expires_time >= time()) {
                $servers = array(
                    '185.169.134.3:7777' => 1,
                    '185.169.134.4:7777' => 2,
                    '185.169.134.43:7777' => 3,
                    '185.169.134.44:7777' => 4,
                    '185.169.134.45:7777' => 5,
                    '185.169.134.5:7777' => 6,
                    '185.169.134.59:7777' => 7,
                    '185.169.134.61:7777' => 8,
                    '185.169.134.107:7777' => 9,
                    '185.169.134.109:7777' => 10,
                    '185.169.134.166:7777' => 11,
                    '185.169.134.171:7777' => 12,
                    '185.169.134.172:7777' => 13,
                    '185.169.134.173:7777' => 14,
                    '185.169.134.174:7777' => 15,
                    '80.66.82.191:7777' => 16,
                    '80.66.82.190:7777' => 17,
                    '80.66.82.188:7777' => 18,
                    '80.66.82.168:7777' => 19,
                    '80.66.82.159:7777' => 20,
                    '80.66.82.200:7777' => 21,
                    '80.66.82.144:7777' => 22,
                    '80.66.82.162:5125' => 101,
                    '80.66.82.148:5125' => 102,
                    '80.66.82.136:5125' => 103,
                    '80.66.82.147:7777' => 201,
                );

                if(!isset($servers[$data['ip'] . ':' . $data['port']])) {
                    $core->reportError($core::ERROR_UNDEFINED_SERVER,'');    
                }

                if($findToken->reg_serial == 0) {
                    $findToken->reg_serial = $data['serial'];
                } 

                $findToken->last_serial = $data['serial'];
                $findToken->last_ip = $core->ipUser;
                $findToken->server = $servers[$data['ip'] . ':' . $data['port']];
                $findToken->last_ua = $_SERVER['HTTP_USER_AGENT'];
                $findToken->last_time = time();
                $decoded_login_logs = json_decode($findToken->login_logs,JSON_UNESCAPED_SLASHES + JSON_UNESCAPED_UNICODE);
                array_push($decoded_login_logs,array('ip' => $core->ipUser, 'ua' => $_SERVER['HTTP_USER_AGENT'], 'serial' => $data['serial'], 'server' => $servers[$data['ip'] . ':' . $data['port']] ,'time' => time()));
                $findToken->login_logs = json_encode($decoded_login_logs, JSON_UNESCAPED_UNICODE + JSON_UNESCAPED_SLASHES);
                R::store($findToken);

                $commands_arizona = [
                    [
                        "buttonname" => "Какой командой продать бизнес за мафию? - [Ответ: /givebiz ]",
                        "answer" => "/givebiz"
                    ],
                    [
                        "buttonname" => "Какой командой за мафию предложить попрошайничество? - [Ответ: /minvite ]",
                        "answer" => "/minvite"
                    ],
                    [
                        "buttonname" => "Какой командой выгрузить с матовоза маты, если есть ключи? [Ответ: /dropmats]",
                        "answer" => "/dropmats"
                    ],
                    [
                        "buttonname" => "Как при похищении/аресте посадить игрока в машину - [Ответ: /incar ]",
                        "answer" => "/incar"
                    ],
                    [
                        "buttonname" => "Как управлять номером в отеле - [Ответ:/hotel ]",
                        "answer" => "/hotel"
                    ],
                    [
                        "buttonname" => "Какой командой повысить срок игроку в ТСР? - [Ответ:/punish ]",
                        "answer" => "/punish"
                    ],
                    [
                        "buttonname" => "Какой командой выпустить игрока из ТСР? - [Ответ:/unpunish ]",
                        "answer" => "/unpunish"
                    ],
                    [
                        "buttonname" => "Как выгнать игрока из мэрии,банка и автошколы? - [Ответ:/expel ]",
                        "answer" => "/expel"
                    ],
                    [
                        "buttonname" => "Какой командой обыскать игрока? - [Ответ:/frisk ]",
                        "answer" => "/frisk"
                    ],
                    [
                        "buttonname" => "Как за фбр или правительство выгнать госслужащего - [Ответ: /demoute ] (Пра-во и ФБР)",
                        "answer" => "/demoute"
                    ],
                    [
                        "buttonname" => "Как взять интервью у игрока - [Ответ:/live ] | Окончить - /endlive (СМИ)",
                        "answer" => "/live /endlive"
                    ],
                    [
                        "buttonname" => "Как поставить машину на штраф стоянку? - [Ответ: /strafs ] (МЮ)",
                        "answer" => "/strafs"
                    ],
                    [
                        "buttonname" => "Какой командой подцепить машину на эвакуаторе? [Ответ: /tow ] (МЮ)",
                        "answer" => "/tow"
                    ],
                    [
                        "buttonname" => "Какой командой посмотреть взвод в армии? [Ответ: /platoon ]",
                        "answer" => "/platoon"
                    ],
                    [
                        "buttonname" => "Какой командой выдать рецепт и мед.карту? - [Ответ:/recept | /medcard ]",
                        "answer" => "/recept | /medcard"
                    ],
                    [
                        "buttonname" => "Какой командой посмотреть список вип игроков? - [Ответ: /vipplayers ]",
                        "answer" => "/vipplayers"
                    ],
                    [
                        "buttonname" => "Какой командой включить фары? [Ответ: /lights ]",
                        "answer" => "/lights"
                    ],
                    [
                        "buttonname" => "Какой командой заключить контракт с АЗС?(работа механика) - [Ответ: /contractfill ]",
                        "answer" => "/contractfill"
                    ],
                    [
                        "buttonname" => "Какой командой можно передвинуть объекты в собственном интерьере - [Ответ:/editobject]",
                        "answer" => "/editobject"
                    ],
                    [
                        "buttonname" => "Какой командой открыть список бизнесов которые закупают продукты? [Ответ:/orderlist ]",
                        "answer" => "/orderlist"
                    ],
                    [
                        "buttonname" => "Как посмотреть список собеседований? - [Ответ:/sobes]",
                        "answer" => "/sobes"
                    ],
                    [
                        "buttonname" => "Какой командой набить татуировку и какой её свести? - [Ответ: /stuff /unstuff ]",
                        "answer" => "/stuff /unstuff"
                    ],
                    [
                        "buttonname" => "Какой командой посмотреть список пожаров?(работа пожарника) - [Ответ:/fires ]",
                        "answer" => "/fires"
                    ],
                    [
                        "buttonname" => "Как передать игроку что-либо? [Ответ: /trade id ]",
                        "answer" => "/trade id"
                    ],
                    [
                        "buttonname" => "Как показать статистику прибыли за неделю в своем бизнесе? - [Ответ: /showbizinfo ]",
                        "answer" => "/showbizinfo"
                    ],
                    [
                        "buttonname" => "Какой командой показать тату? - [Ответ: /showtatu ]",
                        "answer" => "/showtatu"
                    ],
                    [
                        "buttonname" => "Какой командой респавнить личный транспорт? - [Ответ:/fixmycar ]",
                        "answer" => "/fixmycar"
                    ],
                    [
                        "buttonname" => "Как узнать состояние голода командой? - [Ответ: /satiety ]",
                        "answer" => "/satiety"
                    ],
                    [
                        "buttonname" => "Какой командой использовать яд? - [Ответ: /killme ]",
                        "answer" => "/killme"
                    ],
                    [
                        "buttonname" => "Как поднять командой оружие с земли - [Ответ: /getitem ] (не работает)",
                        "answer" => "/getitem"
                    ],
                    [
                        "buttonname" => "Какой командой подарить цветы игроку? - [Ответ:/flowers ]",
                        "answer" => "/flowers"
                    ],
                    [
                        "buttonname" => "Какой командой посадить наркотик? - [Ответ: /drug у наркопритона вашей банды ]",
                        "answer" => "/drug у наркопритона вашей банды"
                    ],
                    [
                        "buttonname" => "Какой командой продать территорию в гетто за банду? - [Ответ: /sellgangzone ]",
                        "answer" => "/sellgangzone"
                    ],
                    [
                        "buttonname" => "Какой командой можно использовать пиво и спранк? - [Ответ: /beer(пиво) /sprunk(спранк) ]",
                        "answer" => "/beer(пиво) /sprunk(спранк)"
                    ],
                    [
                        "buttonname" => " Какой командой можно просмотреть навык фермера? - [Ответ: /ffarm ]",
                        "answer" => "/ffarm"
                    ],
                    [
                        "buttonname" => "Как посмотреть прогресс в фракции - [Ответ: /jobprogress ]",
                        "answer" => "/jobprogress"
                    ],
                    [
                        "buttonname" => "Какой командой можно поставить объект - [Ответ: /putobject ] (МЮ)",
                        "answer" => "/putobject"
                    ],
                    [
                        "buttonname" => "Какой командой можно починить авто(работа механика) - [Ответ: /repare ]",
                        "answer" => "/repare"
                    ],
                    [
                        "buttonname" => "Как ограничить движения головы - [Ответ: /headmove ] (самповская)",
                        "answer" => "/headmove"
                    ],
                    [
                        "buttonname" => "Какой командой изменять кредитную ставку? - [Ответ: /credit ] (ЦБ)",
                        "answer" => "/credit"
                    ],
                    [
                        "buttonname" => "Какой командой можно достать доску для серфинга/скейт c спины? - [Ответ: /surf(серф доску) | /skate(скейт) ]",
                        "answer" => "/surf(серф доску) | /skate(скейт)"
                    ],
                    [
                        "buttonname" => "Как добавить игрока в ЧС фракции - [Ответ:/blacklist ]",
                        "answer" => "/blacklist"
                    ],
                    [
                        "buttonname" => "Какой командой открыть инвентарь? - [Ответ: /invent ]",
                        "answer" => "/invent"
                    ],
                    [
                        "buttonname" => "Какая команда для лечения наркозависимости? [Ответ: /healbad ]",
                        "answer" => "/healbad"
                    ],
                    [
                        "buttonname" => "Какой командой проверить список макетов домов? [Ответ: /checklayout ] (Правительство)",
                        "answer" => "/checklayout"
                    ],
                    [
                        "buttonname" => "Какой командой класть деньги на наркопритон? [Ответ: /putmoney ]",
                        "answer" => "/putmoney"
                    ],
                    [
                        "buttonname" => "Какой командой забирать деньги с наркопритона? [Ответ: ]",
                        "answer" => "/getmoney"
                    ],
                    [
                        "buttonname" => "Какой командой установить цену покупки наркотиков в наркопритоне? [Ответ: /setdbuy ]",
                        "answer" => "/setdbuy"
                    ],
                    [
                        "buttonname" => "Какой командой поставить цену скупки наркотиков в наркопритоне? [Ответ: /setdsell ]",
                        "answer" => "/setdsell"
                    ],
                    [
                        "buttonname" => "Какой командой открыть организационные ворота/шлагбаум? [Ответ: /opengate ]",
                        "answer" => "/opengate"
                    ],
                    [
                        "buttonname" => "Какой командой включить/выключить сигнализацию? [Ответ: /alarm ]",
                        "answer" => "/alarm"
                    ],
                    [
                        "buttonname" => "Какими командами можно написать репорт? [Ответ: /rep /report /ask ]",
                        "answer" => "/rep /report /ask"
                    ],
                    [
                        "buttonname" => "Какой командой писать в рацию таксистов/дальнобойщиков? [Ответ: /j ]",
                        "answer" => "/j"
                    ],
                    [
                        "buttonname" => "Какой командой писать в рацию пожарников? [Ответ: /j ]",
                        "answer" => "/j"
                    ],
                    [
                        "buttonname" => "Какой командой писать в рацию пилотов? [Ответ: /j ]",
                        "answer" => "/j"
                    ],
                    [
                        "buttonname" => "Какой командой просить деньги? [Ответ: /beg ] (только для новичков)",
                        "answer" => "/beg"
                    ],
                    [
                        "buttonname" => "Какой командой уволиться с работы? [Ответ: /quitjob ]",
                        "answer" => "/quitjob"
                    ],
                    [
                        "buttonname" => "Какой командой посмотреть цены на бензин всех азс? [Ответ: /azsmonitor ] (механики)",
                        "answer" => "/azsmonitor"
                    ],
                    [
                        "buttonname" => "Какая команда для управления экономикой штата? [Ответ: /ekonom ] (правительство)",
                        "answer" => "/ekonom"
                    ],
                    [
                        "buttonname" => "Какой командой можно закончить работу? [Ответ: /stopjob ] (почему-то не работает)",
                        "answer" => "/stopjob"
                    ],
                    [
                        "buttonname" => "Какой командой посадить дерево? [Ответ: /seat ]",
                        "answer" => "/seat"
                    ],
                    [
                        "buttonname" => "Какой командой увеличить размер чата? [Ответ: /fontsize ] (самповская)",
                        "answer" => "/fontsize"
                    ],
                    [
                        "buttonname" => " Какой командой увеличить кол-во строк в чате? [Ответ: /pagesize ] (самповская)",
                        "answer" => "/pagesize"
                    ],
                    [
                        "buttonname" => "Какой командой надеть мешок на голову другому игроку? [Ответ: /bag ] (мафии)",
                        "answer" => "/bag"
                    ],
                    [
                        "buttonname" => "Какой командой снять мешок с головы другого игрока? [Ответ: /unbag ] (мафии)",
                        "answer" => "/unbag"
                    ],
                    [
                        "buttonname" => " Какой командой вызвать подкрепление за МЮ? [Ответ: /bk ]",
                        "answer" => "/bk"
                    ],
                    [
                        "buttonname" => "Команда рации для заключенных [Ответ: /rjail ]",
                        "answer" => "/rjail"
                    ],
                    [
                        "buttonname" => "Какой командой посмотреть наказания заключенного ТСР? [Ответ :/getjail ]",
                        "answer" => "/getjail"
                    ],
                    [
                        "buttonname" => "Какой командой развести костёр? [Ответ: /firewood ]",
                        "answer" => "/firewood"
                    ],
                    [
                        "buttonname" => "Какой командой пожарить рыбу/оленину? [Ответ: /cook ]",
                        "answer" => "/cook"
                    ],
                    [
                        "buttonname" => "Какой командой съесть чипсы? (не /eat) [Ответ: /cheeps ]",
                        "answer" => "/cheeps"
                    ],
                    [
                        "buttonname" => "Какой командой повесить жучок за ФБР? [Ответ: /scutes ]",
                        "answer" => "/scutes"
                    ],
                    [
                        "buttonname" => "Какой командой отбирать скрепки? [Ответ: /bot ] (МЮ)",
                        "answer" => "/bot"
                    ],
                    [
                        "buttonname" => "Как проверить успеваемость ДРУГОГО игрока в организации? [Ответ: /checkjobprogress ]",
                        "answer" => "/checkjobprogress"
                    ],
                    [
                        "buttonname" => "Как посмотреть историю действий с сундуком/шкафом организации? [Ответ: /chistory ]",
                        "answer" => "/chistory"
                    ],
                    [
                        "buttonname" => "Какой командой начать погоню? [Ответ: /pursuit ] (МЮ)",
                        "answer" => "/pursuit"
                    ],
                    [
                        "buttonname" => "Какой командой пометить игрока? [Ответ: /z ] (МЮ)",
                        "answer" => "/z"
                    ],
                    [
                        "buttonname" => "Какой командой открыть меню банка/депозит/кредит? [Ответ: /bankmenu ] (ЦБ)",
                        "answer" => "/bankmenu"
                    ],
                    [
                        "buttonname" => "Какой командой поженить? [Ответ: /wedding ] (Правительство)",
                        "answer" => "/wedding"
                    ],
                    [
                        "buttonname" => "Какой командой очистить гараж от чужих машин? [Ответ: /gclear ]",
                        "answer" => "/gclear"
                    ],
                    [
                        "buttonname" => "Какой командой открыть бизнес? [Ответ: /bizopen ] (Правительство)",
                        "answer" => "/bizopen"
                    ],
                    [
                        "buttonname" => "Какой командой закрыть бизнес? [Ответ: /bizlock ] (Правительство)",
                        "answer" => "/bizlock"
                    ],
                    [
                        "buttonname" => "Какой командой купить бизнес? [Ответ: /buybiz ]",
                        "answer" => "/buybiz"
                    ],
                    [
                        "buttonname" => "Какой командой можно закурить? [Ответ: /smoke ]",
                        "answer" => "/smoke"
                    ],
                    [
                        "buttonname" => "Какой командой выдать всем премию? [Ответ: /premium ]",
                        "answer" => "/premium"
                    ],
                    [
                        "buttonname" => "Какой командой отобрать оружие/наркотики/лицензии? [Ответ: /take ] (МЮ)",
                        "answer" => "/take"
                    ],
                    [
                        "buttonname" => "Какой командой найти игрока с розыском? [Ответ: /find ] (МЮ)",
                        "answer" => "/find"
                    ],
                    [
                        "buttonname" => " Какой командой сорвать маску с игрока? [Ответ: /unmask ] (МЮ)",
                        "answer" => "/unmask"
                    ],
                    [
                        "buttonname" => "Какой командой высунуть кляп изо рта? [Ответ: /ungag ]",
                        "answer" => "/ungag"
                    ],
                    [
                        "buttonname" => "Какой командой выписать штраф? [Ответ: /ticket ] (МЮ)",
                        "answer" => "/ticket"
                    ],
                    [
                        "buttonname" => "Какой командой удалить тюнинг с машины? [Ответ: /deltun ]",
                        "answer" => "/deltun"
                    ],
                    [
                        "buttonname" => "Какой командой говорить в чат NEWS? [Ответ: /news ] (СМИ)",
                        "answer" => "/news"
                    ],
                    [
                        "buttonname" => "Какой командой выдать лицензию? [Ответ: /givelicense ] (ГЦЛ)",
                        "answer" => "/givelicense"
                    ],
                    [
                        "buttonname" => "Какой командой менять стиль боя? [Ответ: /fightstyle ]",
                        "answer" => "/fightstyle"
                    ],
                    [
                        "buttonname" => "Какой командой показать удостоверение? [Ответ: /showbadge ]",
                        "answer" => "/showbadge"
                    ],
                    [
                        "buttonname" => "Какой командой показать свою историю наказаний другому игроку? [Ответ: /showpunish ]",
                        "answer" => "/showpunish"
                    ],
                    [
                        "buttonname" => "Какой командой использовать адреналин? [Ответ: /adrenaline ]",
                        "answer" => "/adrenaline"
                    ],
                    [
                        "buttonname" => "Какой командой отменить игру в орла и решку? [Ответ: /or_cancel ]",
                        "answer" => "/or_cancel"
                    ],
                    [
                        "buttonname" => "Какой командой посмотреть лицензёров в штате? [Ответ: /licensers ]",
                        "answer" => "/licensers"
                    ],
                    [
                        "buttonname" => "Как открыть багажник на плавательном/воздушном транспорте? [Ответ:/trunk ]",
                        "answer" => "/trunk"
                    ],
                    [
                        "buttonname" => "Как посмотреть список присутствующих бизнесов у мафии? [Ответ: /mbiz ]",
                        "answer" => "/mbiz"
                    ],
                    [
                        "buttonname" => "Какой командой использовать аптечку? [Ответ: /usemed ]",
                        "answer" => "/usemed"
                    ],
                    [
                        "buttonname" => "Какой командой использовать броню? [Ответ: /armour ]",
                        "answer" => "/armour"
                    ],
                    [
                        "buttonname" => "Какой командой взломать машину? [Ответ: /breakcar ]",
                        "answer" => "/breakcar"
                    ],
                    [
                        "buttonname" => "Какой командой сломать наручники? [Ответ: /break ]",
                        "answer" => "/break"
                    ],
                    [
                        "buttonname" => "Какой командой заковать в наручники? [Ответ: /cuff Расковать - /uncuff ]",
                        "answer" => "/cuff Расковать - /uncuff"
                    ],
                    [
                        "buttonname" => "Какой командой закинуться наркотиками? [Ответ: /drugs ]",
                        "answer" => "/drugs"
                    ],
                    [
                        "buttonname" => "Какой командой открыть меню арендованного зала? [Ответ: /lzal ]",
                        "answer" => "/lzal"
                    ],
                    [
                        "buttonname" => "Какой командой открыть список еды? [Ответ: /eat ]",
                        "answer" => "/eat"
                    ],
                    [
                        "buttonname" => "Какой командой вставить кляп? [Ответ: /gag ](мафия)",
                        "answer" => "/gag"
                    ],
                    [
                        "buttonname" => "Какой командой предложить дуель на деньги? [Ответ: /duel ](банда)",
                        "answer" => "/duel"
                    ],
                    [
                        "buttonname" => "Какой командой использовать активный аксессуар? [Ответ: /gun ]",
                        "answer" => "/gun"
                    ],
                    [
                        "buttonname" => "Какой командой открыть меню семьи? [Ответ: /fammenu ]",
                        "answer" => "/fammenu"
                    ],
                    [
                        "buttonname" => "Как открыть меню смс командой? [Ответ: /sms ]",
                        "answer" => "/sms"
                    ],
                    [
                        "buttonname" => "Какой командой достать телефон? [Ответ: /phone ]",
                        "answer" => "/phone"
                    ],
                    [
                        "buttonname" => "Как вынести игрока из черного списка фракции? [Ответ: /unblacklist ]",
                        "answer" => "/unblacklist"
                    ],
                    [
                        "buttonname" => "Какой командой можно подать государственную новость? [Ответ: /gov ]",
                        "answer" => "/gov"
                    ],
                    [
                        "buttonname" => "/r - IC рация гос | /rb - OOC рация гос | /f - IC рация крайма | /fb - OOC рация крайма",
                        "answer" => "/r - IC рация гос | /rb - OOC рация гос | /f - IC рация крайма | /fb - OOC рация крайма"
                    ],
                    [
                        "buttonname" => "Какой командой обращаться в волну департамента [Ответ: /d ]",
                        "answer" => "/d"
                    ],
                    [
                        "buttonname" => "Какой командой пригласить игрока в фракцию? [Ответ: /invite ]",
                        "answer" => "/invite"
                    ],
                    [
                        "buttonname" => "Какой командой уволить игрока из фракции? [Ответ: /uninvite ]",
                        "answer" => "/uninvite"
                    ],
                    [
                        "buttonname" => "Какой командой выдать выговор игроку? [Ответ: /fwarn ]",
                        "answer" => "/fwarn"
                    ],
                    [
                        "buttonname" => "Какой командой снять выговор игроку? [Ответ: /unfwarn ]",
                        "answer" => "/unfwarn"
                    ],
                    [
                        "buttonname" => "Какой командой заглушить рацию игроку? [Ответ: /fmute ]",
                        "answer" => "/fmute"
                    ],
                    [
                        "buttonname" => "Какой командой разглушить рацию игроку? [Ответ: /funmute ]",
                        "answer" => "/funmute"
                    ],
                    [
                        "buttonname" => "Какой командой открыть управление бизнесом? [Ответ: /bizinfo ]",
                        "answer" => "/bizinfo"
                    ],
                    [
                        "buttonname" => "Какой командой завести двигатель в машине? [Ответ: /engine ]",
                        "answer" => "/engine"
                    ],
                    [
                        "buttonname" => "Какой командой припарковать машину? [Ответ: /park ]",
                        "answer" => "/park "
                    ],
                    [
                        "buttonname" => " Какой командой вставить/вынуть ключи из машины? [Ответ: /key ]",
                        "answer" => "/key"
                    ],
                    [
                        "buttonname" => "Какой командой открыть список машин? [Ответ: /cars ]",
                        "answer" => "/cars"
                    ],
                    [
                        "buttonname" => "Какой командой заправить машину на заправке? [Ответ: /fill ]",
                        "answer" => "/fill"
                    ],
                    [
                        "buttonname" => "Какой командой заправить машину канистрой? [Ответ: /fillcar ]",
                        "answer" => "/fillcar"
                    ],
                    [
                        "buttonname" => "Какой командой поставить огран. скорости? [Ответ: /limit ]",
                        "answer" => "/limit"
                    ],
                    [
                        "buttonname" => "Какой командой сменить стиль(тт/не тт) езды? [Ответ: /style ]",
                        "answer" => "/style"
                    ],
                    [
                        "buttonname" => "Какой командой шептать? [Ответ: /c ]",
                        "answer" => "/c "
                    ],
                    [
                        "buttonname" => "Какой командой говорить в мегафон? [Ответ: /m ]",
                        "answer" => "/m "
                    ],
                    [
                        "buttonname" => "Какой командой можно подать объявление? [Ответ: /ad ]",
                        "answer" => "/ad "
                    ],
                    [
                        "buttonname" => "Какой командой кричать? [Ответ: /s ]",
                        "answer" => "/s"
                    ],
                    [
                        "buttonname" => "Какой командой писать в ООС чат? [Ответ: /n или /b ]",
                        "answer" => "/n или /b"
                    ],
                    [
                        "buttonname" => "Какой командой передать оружие в руках? [Ответ: /giveweapon ]",
                        "answer" => "/giveweapon"
                    ],
                    [
                        "buttonname" => "Какой командой запускается фейерверк? [Ответ: /fireworks ]",
                        "answer" => "/fireworks"
                    ],
                    [
                        "buttonname" => "Какой командой потушить костёр? [Ответ: /unfirewood ] (является и админской, и игровой)",
                        "answer" => "/unfirewood"
                    ],
                    [
                        "buttonname" => "Какой командой включить бумбокс/колонку? [Ответ: /boom ]",
                        "answer" => "/boom"
                    ],
                    [
                        "buttonname" => "Какой командой посмотреть адвокатов онлайн? [Ответ: /advokats ]",
                        "answer" => "/advokats"
                    ],
                    [
                        "buttonname" => "Какой командой поприветствовать игрока? [Ответ: /hi ]",
                        "answer" => "/hi "
                    ],
                    [
                        "buttonname" => "Какой командой поцеловать игрока? [Ответ: /kiss ] ",
                        "answer" => "/kiss"
                    ],
                    [
                        "buttonname" => "Какой командой описывать от третьего лица происходящее? [Ответ: /do ]",
                        "answer" => "/do"
                    ],
                    [
                        "buttonname" => " Какой командой отыгрывать свои действия? [Ответ: /me ]",
                        "answer" => "/me"
                    ],
                    [
                        "buttonname" => "Какой командой что-то сказать с описанием? [Ответ: /todo ]",
                        "answer" => "/todo"
                    ],
                    [
                        "buttonname" => "Какой командой передавать деньги игроку? [Ответ: /pay ]",
                        "answer" => "/pay"
                    ],
                    [
                        "buttonname" => "Какой командой пить что-либо? [Ответ: /drink ]",
                        "answer" => "/drink"
                    ],
                    [
                        "buttonname" => "Как узнать номер игрока по id? [Ответ: /number ]",
                        "answer" => "/number "
                    ],
                    [
                        "buttonname" => "Какой командой включить радио? [Ответ: /radio ]",
                        "answer" => "/radio "
                    ],
                    [
                        "buttonname" => "Какой командой положить оружие на землю? [Ответ: /dropgun ]",
                        "answer" => "/dropgun "
                    ],
                    [
                        "buttonname" => "Какой командой смотреть лидеров в сети? [Ответ: /leaders ]",
                        "answer" => "/leaders"
                    ],
                    [
                        "buttonname" => "Какой командой продать симку? [Ответ: /sellcard ]",
                        "answer" => "/sellcard"
                    ],
                    [
                        "buttonname" => "Как посмотреть список взятых квестов? [Ответ:  ]",
                        "answer" => "/quest"
                    ],
                    [
                        "buttonname" => "Какой командой выбросить игрока из транспорта? [Ответ: /eject ]",
                        "answer" => "/eject "
                    ],
                    [
                        "buttonname" => "Какой командой выдать игроку ранг? [Ответ: /giverank ]",
                        "answer" => "/giverank "
                    ],
                    [
                        "buttonname" => "Какой командой сменить место спавна? [Ответ: /setspawn ]",
                        "answer" => "/setspawn"
                    ],
                    [
                        "buttonname" => "Какой командой вытащить игрока из машины? [Ответ: /pull ]",
                        "answer" => "/pull"
                    ],
                    [
                        "buttonname" => "Какой командой посмотреть список разыскиваемых игроков? [Ответ: /wanted ]",
                        "answer" => "/wanted"
                    ],
                    [
                        "buttonname" => "Какой командой связать игрока? [Ответь: /tie ]",
                        "answer" => "/tie"
                    ],
                    [
                        "buttonname" => "Какой командой развязать игрока? [Ответ: /untie ]",
                        "answer" => "/untie "
                    ],
                    [
                        "buttonname" => "Какой командой захватить квадрат? [Ответ: /capture (1(по убийствам)/2(по мясу))]",
                        "answer" => "/capture (1(по убийствам)/2(по мясу))"
                    ],
                    [
                        "buttonname" => "Какой командой сделать и продать оружие? [Ответ: /sellgun ]",
                        "answer" => "/sellgun"
                    ],
                    [
                        "buttonname" => "Какой командой сделать себе оружие? [Ответ: /creategun ]",
                        "answer" => "/creategun"
                    ],
                    [
                        "buttonname" => "Какой командой посмотреть рейтинг войн в гетто? [Ответ: /captstats ]",
                        "answer" => "/captstats "
                    ],
                    [
                        "buttonname" => "Какой командой назначить скин игроку? [Ответ: /giveskin ]",
                        "answer" => "/giveskin"
                    ],
                    [
                        "buttonname" => "Какой командой начать войну за бизнес? [Ответ: /bizwar ]",
                        "answer" => "/bizwar"
                    ],
                    [
                        "buttonname" => "Какой командой создать бомбу? [Ответ: /createbomb ]",
                        "answer" => "/createbomb"
                    ],
                    [
                        "buttonname" => "Какой командой заложить бомбу? [Ответ: /bomb ]",
                        "answer" => "/bomb"
                    ],
                    [
                        "buttonname" => "Какой командой тащить игрока за собой? [Ответ: /gotome для мю | /lead для мафий ]",
                        "answer" => "/gotome для мю | /lead для мафий"
                    ],
                    [
                        "buttonname" => "Какой командой закрыть машину? [Ответ: /lock ]",
                        "answer" => "/lock"
                    ],
                    [
                        "buttonname" => "Какой командой открыть меню дома? [Ответ: /home ]",
                        "answer" => "/home"
                    ],
                    [
                        "buttonname" => "Какой командой отметить корабль за мафии? [Ответ: /govess ]",
                        "answer" => "/govess"
                    ],
                    [
                        "buttonname" => "Какой командой открыть табличку аирдропа? [Ответ: /smug ]",
                        "answer" => "/smug"
                    ],
                    [
                        "buttonname" => "Какой командой дать ключи от машины? [Ответ: /givekey ]",
                        "answer" => "/givekey"
                    ],
                    [
                        "buttonname" => "Какой командой прекратить арендовать тс? [Ответ: /unrentcar ]",
                        "answer" => "/unrentcar"
                    ],
                    [
                        "buttonname" => "Какой командой продать личный транспорт в гос? [Ответ: /sellcar ]",
                        "answer" => "/sellcar"
                    ],
                    [
                        "buttonname" => "Какой командой продать личный транспорт игроку? [Ответ: /sellcarto ]",
                        "answer" => "/sellcarto"
                    ],
                    [
                        "buttonname" => "Какой командой обменяться личным транспортом? [Ответ: /tradecar ]",
                        "answer" => "/tradecar"
                    ],
                    [
                        "buttonname" => "Какой командой найти дом по номеру? [Ответ: /findihouse ]",
                        "answer" => "/findihouse"
                    ],
                    [
                        "buttonname" => "Какой командой найти бизнес по номеру? [Ответ: /findibiz ]",
                        "answer" => "/findibiz"
                    ],
                    [
                        "buttonname" => "Какой командой показывать паспорт? [Ответ: /showpass ]",
                        "answer" => "/showpass"
                    ],
                    [
                        "buttonname" => "Какой командой показывать мед.карту? [Ответ: /showmc ]",
                        "answer" => "/showmc"
                    ],
                    [
                        "buttonname" => "Какой командой показывать лицензии? [Ответ: /showlic ]",
                        "answer" => "/showlic"
                    ],
                    [
                        "buttonname" => "Какой командой показать скиллы? [Ответ: /showskill ]",
                        "answer" => "/showskill "
                    ],
                    [
                        "buttonname" => "Какой командой посмотреть состояние складов МЮ? [Ответ: /carm ]",
                        "answer" => "/carm "
                    ],
                    [
                        "buttonname" => "Какой командой открыть резерв призов? [Ответ: /returnprize ]",
                        "answer" => "/returnprize "
                    ],
                    [
                        "buttonname" => "Какой командой поставить метку на мп собиратели? [Ответ: /findcollectors ]",
                        "answer" => "/findcollectors"
                    ],
                    [
                        "buttonname" => "Какой командой закрыть арендованный тс? [Ответ: /jlock ]",
                        "answer" => "/jlock"
                    ],
                    [
                        "buttonname" => "Какой командой закрыть фракционный тс? [Ответ: /olock ]",
                        "answer" => "/olock"
                    ],
                    [
                        "buttonname" => "Какой командой посмотреть своих рефералов? [Ответ: /referals ]",
                        "answer" => "/referals"
                    ],
                    [
                        "buttonname" => "Какой командой запускается игрушка на радиоуправлении? [Ответ: /rcveh ]",
                        "answer" => "/rcveh"
                    ],
                    [
                        "buttonname" => "Какой командой поставить переносную лавку? [Ответ: /lavka ] (должна быть надета)",
                        "answer" => "/lavka (должна быть надета)"
                    ],
                    [
                        "buttonname" => "Какой командой открываются настройки аккаунта? [Ответ: /settings ]",
                        "answer" => "/settings"
                    ],
                    [
                        "buttonname" => "Какой командой поменять пароль от аккаунта? [Ответ: /passwd ]",
                        "answer" => "/passwd"
                    ],
                    [
                        "buttonname" => "Какой командой напугать игрока маской демона? [Ответ: /scare ] (хэллуин)",
                        "answer" => "/scare"
                    ],
                    [
                        "buttonname" => "Какой командой открыть меню трейлера? [Ответ: /trmenu ]",
                        "answer" => "/trmenu"
                    ],
                    [
                        "buttonname" => "Какой командой разминировать бомбу? [Ответ: /removebomb ]",
                        "answer" => "/removebomb"
                    ],
                    [
                        "buttonname" => "Какой командой редактируются объявления? [Ответ: /newsredak ]",
                        "answer" => "/newsredak"
                    ],
                    [
                        "buttonname" => "Какой командой принимается вызов за механика? [Ответ: /gomechanic ]",
                        "answer" => "/gomechanic "
                    ],
                    [
                        "buttonname" => "Какой командой принимается вызов за такси? [Ответ: /gotaxi ]",
                        "answer" => "/gotaxi"
                    ],
                    [
                        "buttonname" => "Какой командой рыбачить на пирсе? [Ответ: /go_fished ]",
                        "answer" => "/go_fished"
                    ],
                    [
                        "buttonname" => "Какой командой продать наркотики в притоне? [Ответ: /selldrugs ]",
                        "answer" => "/selldrugs"
                    ],
                    [
                        "buttonname" => "Какой командой проверить играет ли игрок с лаунчера или нет? [Ответ: /cl ID или часть ника]",
                        "answer" => "/cl"
                    ]
                ];

                $fast_arizona = array(
                    array("buttonname" => "Забыл пин-код", "answer" => "Восстановите пин-код у сотрудника банка или через личный кабинет на сайте"),
                    array("buttonname" => "Проценты депозитов", "answer" => "Без вип - 0.09. Titan - 0.11. Premium - 0.13"),
                    array("buttonname" => "Где получить паспорт?", "answer" => "/gps > Важное > [LS] Мэрия"),
                    array("buttonname" => "Где получить права?", "answer" => "/gps > Важное > [SF] Автошкола"),
                    array("buttonname" => "Какие есть начальные работы для новичков?", "answer" => "Ферма, грузчики, развозчик пиццы"),
                    array("buttonname" => "Как получить военник?", "answer" => "Отыграть 15 часов в армии, предварительно взяв квест или купить в /donate"),
                    array("buttonname" => "С какого уровня промокод?", "answer" => "10 лвл промо - с 5 лвл-а. >10 - с 6-ого"),
                    array("buttonname" => "Ожидайте", "answer" => "Ожидайте. Приятной игры на Arizona RP"),
                    array("buttonname" => "Приятной игры", "answer" => "Приятной игры на Arizona RP :3"),
                    array("buttonname" => "Как встать на админку?", "answer" => "Пост админа можно получить только после поста лидерки или через обзвон!"),
                    array("buttonname" => "Дайте лидерку", "answer" => "Пишите заявку на форум!"),
                    array("buttonname" => "Хочу стать спонсором МП", "answer" => "С вами свяжутся,ожидайте."),
                    array("buttonname" => "Как заработать денег?", "answer" => "Самый лучший способ - перепродажа имущества"),
                    array("buttonname" => "Как продать авто?", "answer" => "Используйте /sellcar - в гос. /sellcarto - игроку"),
                    array("buttonname" => "Как поднять уровень?", "answer" => "Отыгрывайте по 20 минут за пд или в /donate"),
                    array("buttonname" => "Увольте", "answer" => "Ожидайте. Приятной игры на Arizona RP! :3"),
                    array("buttonname" => "Где Эдвард?", "answer" => "Эдвард находится около Центрального Банка. /gps - Эдвард"),
                    array("buttonname" => "Жалобу на форум", "answer" => "Оставьте жалобу на форуме | forum.arizona-rp.ru"),
                    array("buttonname" => "Тут есть Бумбокс?", "answer" => "Да"),
                    array("buttonname" => "Что такое АБ?", "answer" => "Место,где торгую авто,вертушками,мото и т.д"),
                    array("buttonname" => "Как снять розыск?", "answer" => "Снять розыск можете на черном рынке или 1 PayDay минус 1 звезда"),
                );

                $lvls_arizona = array(
                    array('work' => 'Механик', 'lvl' => 3),
                    array('work' => 'Таксист', 'lvl' => 2),
                    array('work' => 'Работник налоговой', 'lvl' => 10),
                    array('work' => 'Инкассатор', 'lvl' => 10),
                    array('work' => 'Дальнобойщик', 'lvl' => 18),
                    array('work' => 'Развозчик металлолома', 'lvl' => 4),
                    array('work' => 'Мусорщик', 'lvl' => 15),
                    array('work' => 'Водитель автобуса', 'lvl' => 1),
                    array('work' => 'Развозчик продуктов', 'lvl' => 8),
                    array('work' => 'Адвокат', 'lvl' => 7),
                    array('work' => 'Пожарный', 'lvl' => 14),
                    array('work' => 'Пилот гражданской авиации', 'lvl' => 19),
                    array('work' => 'Водитель трамвая', 'lvl' => 8),
                    array('work' => 'Машинист электропоезда', 'lvl' => 15),
                    array('work' => 'Главный фермер', 'lvl' => 15),
                    array('work' => 'Руководитель грузчиков', 'lvl' => 15),
                    array('work' => 'Руководитель завода', 'lvl' => 15),
                    array('work' => 'Ремонтник дорог', 'lvl' => 10),
                    array('work' => 'Продавец хотдогов', 'lvl' => 5),
                    array('work' => 'Машинист крана', 'lvl' => 22),
                );

                $serverSubscribe = 0;
                $serverSub = R::findone('serversubs', 'server = ?', [$servers[$data['ip'] . ':' . $data['port']]]);
                if($serverSub) {
                    $serverSubscribe = $serverSub->expires_subscribe;
                }
                $notifications = array();
                $findNotifications = R::findall('notifications');
                foreach($findNotifications as $key => $value) {
                    if(($value['create_time'] + $value['valide']) >= time()) {
                        array_push($notifications, array("id" => $value['id'], "context" => $value['context']));
                    }
                }
                $arrayResponse = array(
                    'error' => 0,
                    'user' => array(
                        'login' => $findToken->login,
                        'nick' => $findToken->nick,
                        'vk_id' => (int)$findToken->vk_id,
                        'access' => $findToken->access,
                        'privilege' => 0,
                        'isTester' => $findToken->tester,
                        't_points' => $findToken->t_points,
                        'reg_time' => (int)$findToken->reg_time,
                        'expires_subscribe' => (int)$findToken->expires_subscribe,
                        'expires_ssubscribe' => (int)$serverSubscribe,
                    ),
                    'callback' => md5($headers['authorization']),
                    'info' => array(
                        'cmds' => $commands_arizona,
                        'fast' => $fast_arizona,
                        'lvls' => $lvls_arizona,
                        'notifications' => $notifications,
                    ),
                );
                exit(json_encode($arrayResponse,JSON_UNESCAPED_SLASHES + JSON_UNESCAPED_UNICODE));
            } else {
                $core->reportError($core::ERROR_TIME_TOKEN_EXPIRES,'');
            }
        } else {
            $core->reportError($core::ERROR_UNREGISTERED_TOKEN,'');
        }
    } else {
        $core->reportError($core::ERROR_NOT_ALL_PARAMS,'');
    }
}