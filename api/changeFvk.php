<?php

require 'ApiCore.php';
$core = new ApiCore();
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);

$core->checkRefer();
$core->isBlocked();

$headers = array_change_key_case(getallheaders());
if($_SERVER['REQUEST_METHOD'] != 'OPTIONS') {
    if(isset($data['vk_id'],$headers['authorization'])) {
        $findToken = R::findone('accounts','auth_token = ?', [$headers['authorization']]);
    
        if($findToken) {
            if($findToken->expires_time >= time()) {


                if(preg_match('/^https?:\/\/?(www\.)?vk\.com\/([\w|\d]+?)\/?$/',$data['vk_id'],$foo)) {
                    $userInfo = $vk->request("users.get", ["user_ids" => $foo[2]]);
                    $data['vk_id'] = $userInfo[0]['id'];
                    if(!$data['vk_id']) {
                        $core->reportError($core::ERROR_UNCORRECT_VK,'');
                    }
                } else {
                    $core->reportError($core::ERROR_UNCORRECT_VK,'');
                }


                
                if($findToken->vk_id != $data['vk_id']) {
                    $findEmail = R::findone('accounts','vk_id = ?',[$data['vk_id']]);
                    if(!$findEmail) {
                        $isRealVK = R::findone('changevk','login = ?',[$findToken->login]);
                        if($isRealVK) {
                            $delete = R::load('changevk', $isRealVK->id);
                            R::trash($delete);
                        }
                        
                        $accept_code = mt_rand(100000,999999);
                        $bufferCodes = R::dispense('changevk');
                        $bufferCodes->login = $findToken->login;
                        $bufferCodes->vk_id = $findToken->vk_id;
                        $bufferCodes->change = $data['vk_id'];
                        $bufferCodes->secret = $accept_code;
                        $bufferCodes->time = time();
                        R::store($bufferCodes);
                        $vk->SendMessage($findToken->vk_id,"Используйте следующий код для отвязки вашего VK. Если вы получили это сообщение случайно - проигнорируйте его.\n\nКод: $accept_code\n\nИнформация:\n— Логин: " . $findToken->login . "\n— Ник: " . $findToken->nick);
                        $core->reportError($core::NO_ERROR,'');
                    } else {
                        $core->reportError($core::ERROR_VK_RESERVED,'');
                    }
                } else {
                    $core->reportError($core::ERROR_VK_ALREADY_THIS,'');
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