<?php

require 'ApiCore.php';
$core = new ApiCore();
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);

$core->checkRefer();
$core->isBlocked();

$headers = array_change_key_case(getallheaders());
if($_SERVER['REQUEST_METHOD'] != 'OPTIONS') {
    if(isset($headers['authorization'])) {
        $findToken = R::findone('accounts','auth_token = ?', [$headers['authorization']]);
    
        if($findToken) {
            if($findToken->expires_time >= time()) {
                $findToken->last_ip = $core->ipUser;
                $findToken->last_ua = $_SERVER['HTTP_USER_AGENT'];
                $findToken->last_time = time();
                $decoded_login_logs = json_decode($findToken->login_logs,JSON_UNESCAPED_SLASHES + JSON_UNESCAPED_UNICODE);
                array_push($decoded_login_logs,array('ip' => $core->ipUser, 'ua' => $_SERVER['HTTP_USER_AGENT'], 'time' => time()));
                $findToken->login_logs = json_encode($decoded_login_logs, JSON_UNESCAPED_UNICODE + JSON_UNESCAPED_SLASHES);
                R::store($findToken);
                //$userInfo = $vk->request("users.get", ["user_ids" => $findToken->vk_id, 'fields' => 'photo_200',"lang" => 'ru']);
                $reversedLog_logs = array_reverse($decoded_login_logs);
                $isOnline = false;
                foreach($reversedLog_logs as $key => $value) {
                    if ($value['ua'] == "LuaSocket 3.0-rc1") {
                        if ((time() - 180) <= $value['time']) {
                            $isOnline = true;
                            break;
                        } else {
                            break;
                        }
                    }
                }
                $arrayResponse = array(
                    'error' => 0,
                    'user' => array(
                        'login' => $findToken->login,
                        'nick' => $findToken->nick,
                        'vk_id' => (int)$findToken->vk_id,
                        'access' => (int)$findToken->access,
                        'balance' => (int)$findToken->balance,
                        'server' => (int)$findToken->server,
                        'isTester' => (boolean)$findToken->tester,
                        'expires_subscribe' => (int)$findToken->expires_subscribe,
                        'accept_security' => (boolean)$findToken->accept_security,
                        'regTime' => (int)$findToken->reg_time,
                        'isOnline' => $isOnline,
                        'serverName' => $core->getServerName($findToken->server - 1),
                        'lastSerial' => (int)$findToken->last_serial,
                        'regSerial' => (int)$findToken->reg_serial,
                        "regIp" => $findToken->reg_ip,
                        "lastIp" => $findToken->last_ip,
                        "lastAuth" => (int)$findToken->last_time,
                        "logs_orders" => $findToken->logs_orders
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
        header('HTTP/1.0 403 Forbidden');
        die('Forbidden');
    }
}