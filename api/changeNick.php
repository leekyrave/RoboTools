<?php
require 'ApiCore.php';
$core = new ApiCore();
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);

$core->isBlocked();

$headers = array_change_key_case(getallheaders());
if($_SERVER['REQUEST_METHOD'] != 'OPTIONS') {
    if(isset($data['nick'],$headers['authorization'])) {
        $findToken = R::findone('accounts','auth_token = ?', [$headers['authorization']]);
    
        if($findToken) {
            if($findToken->expires_time >= time()) {
                if(!preg_match('/^[A-Za-z0-9\._\$@=\(\)\[\]]{3,20}$/',$data['nick'])) {
                    $core->reportError($core::ERROR_UNCORRECT_NICK,'');
                }
                if($findToken->nick != $data['nick']) {
                    $findNick = R::findone('accounts','nick = ?', [$data['nick']]);
                    if(!$findNick) {
                        $decoded_logs = json_decode($findToken->logs, JSON_UNESCAPED_SLASHES + JSON_UNESCAPED_UNICODE);
                        array_push($decoded_logs,array('type' => 'changeNick', 'been' => $findToken->nick, 'begin' => $data['nick'], 'time' => time()));
                        $findToken->nick = $data['nick'];
                        $findToken->logs = json_encode($decoded_logs,JSON_UNESCAPED_UNICODE + JSON_UNESCAPED_SLASHES);
                        R::store($findToken);
                        $core->reportError($core::NO_ERROR,'');
                    } else {
                        $core->reportError($core::ERROR_NICK_RESERVED,'');
                    }
                } else {
                    $core->reportError($core::ERROR_NICK_ALREADY_THIS,'');
                }
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