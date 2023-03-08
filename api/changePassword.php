<?php

require 'ApiCore.php';
$core = new ApiCore();
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);

$core->isBlocked();

$headers = array_change_key_case(getallheaders());
if($_SERVER['REQUEST_METHOD'] != 'OPTIONS') {
    if(isset($data['password'],$data['preview_password'],$headers['authorization'])) {
        $findToken = R::findone('accounts','auth_token = ?', [$headers['authorization']]);
    
        if($findToken) {
            if($findToken->expires_time >= time()) {
                if(iconv_strlen($data['password']) < 4 or iconv_strlen($data['password']) > 32) {
                    $core->reportError($core::ERROR_UNALLOWED_LENGTH,'');
                }
                
                if($findToken->password == md5($data['preview_password'] . 'lol-cringe-salt')) {
                    if($findToken->password != md5($data['password'] . 'lol-cringe-salt')) {
                        $decoded_logs = json_decode($findToken->logs, JSON_UNESCAPED_SLASHES + JSON_UNESCAPED_UNICODE);
                        array_push($decoded_logs,array('type' => 'changePassword', 'been' => $findToken->password, 'begin' => md5($data['password'] . 'lol-cringe-salt'), 'time' => time()));
                        $findToken->password = md5($data['password'] . 'lol-cringe-salt');
                        $findToken->logs = json_encode($decoded_logs,JSON_UNESCAPED_UNICODE + JSON_UNESCAPED_SLASHES);
                        $time_cookie = time();   
                        $auth_token = sha1($findToken->login) . '.' . sha1($findToken->email) . '.' . sha1($findToken->vk_id) . '.' . sha1($findToken->password) . '.' . sha1('mini-secret-key' . $time_cookie);
                        $findToken->auth_token = $auth_token;
                        $findToken->expires_time = $time_cookie + 60*60*24*365;
                        R::store($findToken);
                        setcookie('auth.token',$auth_token, $time_cookie + 60*60*24*365, "/", NULL);
                        setcookie('auth.create-time',$time_cookie,$time_cookie + 60*60*24*365, "/", NULL);
                        setcookie('auth.always-sign-in','1',$time_cookie + 60*60*24*365*365, "/", NULL);
                        $core->reportError($core::NO_ERROR,'');
                    } else {
                        $core->reportError($core::ERROR_PASSWORD_ALREADY_THIS,'');
                    }
                } else {
                    $core->reportError($core::ERROR_PASSWORD_UNCORRECT,'');
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