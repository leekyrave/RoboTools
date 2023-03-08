<?php
require 'ApiCore.php';
$core = new ApiCore();
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);

$core->checkRefer();
$core->isBlocked();

if(isset($data['login'],$data['secret'])) {

    $codeInfo = R::findone('vkcodes','login = ? AND secret = ?', [$data['login'],$data['secret']]);

    if($codeInfo) {
        
        $isRealVK = R::findone('vkcodes','vk_id = ?',[$codeInfo['vk_id']]);
        if($isRealVK) {
            $delete = R::load('vkcodes', $isRealVK->id);
            R::trash($delete);
        }

        $findLogin = R::findone('accounts','login = ?',[$data['login']]);
        $time_cookie = time();
        $auth_token = sha1($data['login']) . '.' . sha1($findLogin->vk_id) . '.' . sha1($findLogin->password) . '.' . sha1('mini-secret-key' . $time_cookie);
        $findLogin->auth_token = $auth_token;
        $findLogin->expires_time = $time_cookie + 60*60*24*365;
        $findLogin->last_time = time();
        $decoded_login_logs = json_decode($findLogin->login_logs,JSON_UNESCAPED_SLASHES + JSON_UNESCAPED_UNICODE);
        array_push($decoded_login_logs,array('ip' => $core->ipUser, 'ua' => $_SERVER['HTTP_USER_AGENT'], 'time' => time()));
        $findLogin->login_logs = json_encode($decoded_login_logs, JSON_UNESCAPED_UNICODE + JSON_UNESCAPED_SLASHES);
        $findLogin->auth_token = $auth_token;
        $findLogin->expires_time = $time_cookie + 60*60*24*365;
        R::store($findLogin);
        setcookie('auth.token',$auth_token, $time_cookie + 60*60*24*365, "/", NULL);
        setcookie('auth.create-time',$time_cookie,$time_cookie + 60*60*24*365, "/", NULL);
        setcookie('auth.always-sign-in','1',$time_cookie + 60*60*24*365*365, "/", NULL);
        $core->reportError($core::NO_ERROR,'authorized');
    } else {
        $core->reportError($core::ERROR_BAD_CODE,'Unregistered Code');
    }
} else {
    
}