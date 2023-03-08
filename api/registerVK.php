<?php
require 'ApiCore.php';
$core = new ApiCore();
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);

$core->checkRefer();
$core->isBlocked();

if(isset($data['vk_id'],$data['secret'])) {

    if(preg_match('/^https?:\/\/?(www\.)?vk\.com\/([\w|\d]+?)\/?$/',$data['vk_id'],$foo)) {
        $userInfo = $vk->request("users.get", ["user_ids" => $foo[2]]);
        $data['vk_id'] = $userInfo[0]['id'];
        if(!$data['vk_id']) {
            $core->reportError($core::ERROR_UNCORRECT_VK,'');
        }
    } else {
        $core->reportError($core::ERROR_UNCORRECT_VK,'');
    }

    $codeInfo = R::findone('vkcodes','vk_id = ? AND secret = ?', [$data['vk_id'],$data['secret']]);
    if($codeInfo) {
        
        $isRealVK = R::findone('vkcodes','vk_id = ?',[$data['vk_id']]);
        if($isRealVK) {
            $delete = R::load('vkcodes', $isRealVK->id);
            R::trash($delete);
        }


        

        if(R::findone('accounts','login = ?',[$codeInfo['login']])) {
            $core->reportError($core::ERROR_LOGIN_EXIST,'');
        }
    
        if(R::findone('accounts','nick = ?',[$codeInfo['nick']])) {
            $core->reportError($core::ERROR_NICK_EXIST,'');
        }
    
        if(R::findone('accounts','vk_id = ?',[$data['vk_id']])) {
            $core->reportError($core::ERROR_VK_EXIST,'');
        }

        
        $createNewUser = R::dispense('accounts');
        $createNewUser->login = $codeInfo['login'];
        $createNewUser->nick = $codeInfo['nick'];
        $createNewUser->vk_id = $data['vk_id'];
        $createNewUser->password = $codeInfo['password'];
        $createNewUser->access = 1;
        $createNewUser->reg_ip = $core->ipUser;
        $createNewUser->last_ip = $core->ipUser;
        $createNewUser->reg_ua = $_SERVER['HTTP_USER_AGENT'];
        $createNewUser->last_ua = $_SERVER['HTTP_USER_AGENT'];
        $createNewUser->tester = false;
        $createNewUser->t_points = 0;
        $createNewUser->server = 0;
        $createNewUser->logs = json_encode(array(),JSON_UNESCAPED_SLASHES + JSON_UNESCAPED_UNICODE);
        $createNewUser->login_logs = json_encode(array(array('ip' => $core->ipUser, 'ua' => $_SERVER['HTTP_USER_AGENT'], 'time' => time())),JSON_UNESCAPED_UNICODE + JSON_UNESCAPED_SLASHES);
        $createNewUser->accept_security = true;
        $createNewUser->reg_serial = 0;
        $createNewUser->last_serial = 0;
        $createNewUser->reg_time = time();
        $createNewUser->last_time = time();
        $createNewUser->logs_orders = json_encode(array(), JSON_UNESCAPED_SLASHES + JSON_UNESCAPED_UNICODE);
        $createNewUser->balance = 0;
        $createNewUser->expires_subscribe = 0;
        $time_cookie = time();
        $auth_token = sha1($codeInfo['login']) . '.' . sha1($codeInfo['vk_id']) . '.' . sha1($codeInfo['password']) . '.' . sha1('mini-secret-key' . $time_cookie);
        $createNewUser->auth_token = $auth_token;
        $createNewUser->expires_time = $time_cookie + 60*60*24*365;
        R::store($createNewUser);
        setcookie('auth.token',$auth_token, $time_cookie + 60*60*24*365, "/", NULL);
        setcookie('auth.create-time',$time_cookie,$time_cookie + 60*60*24*365, "/", NULL);
        setcookie('auth.always-sign-in','1',$time_cookie + 60*60*24*365*365, "/", NULL);
        $core->reportError($core::NO_ERROR,'registered');
    } else {
        $core->reportError($core::ERROR_BAD_CODE,'Unregistered Code');
    }
} else {
    
}