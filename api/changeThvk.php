<?php

require 'ApiCore.php';
$core = new ApiCore();
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);

$core->checkRefer();
$core->isBlocked();

$headers = array_change_key_case(getallheaders());
if($_SERVER['REQUEST_METHOD'] != 'OPTIONS') {
    if(isset($data['secret'],$headers['authorization'])) {
        $findToken = R::findone('accounts','auth_token = ?', [$headers['authorization']]);
    
        if($findToken) {
            if($findToken->expires_time >= time()) {
                $findCheck = R::findone('changenewvk','login = ? AND secret = ?',[$findToken->login, $data['secret']]);
                if($findCheck) {

                    if(time() - $findCheck->time <= 240)
                    {
                        $delete = R::load('changenewvk', $findCheck->id);
                        R::trash($delete);

                        $findEmail = R::findone('accounts','vk_id = ?',[$findCheck->change]);
                        if(!$findEmail) {
                            $decoded_logs = json_decode($findToken->logs, JSON_UNESCAPED_SLASHES + JSON_UNESCAPED_UNICODE);
                            array_push($decoded_logs,array('type' => 'changeVK', 'been' => $findCheck->vk_id, 'begin' => $findCheck->change, 'time' => time()));
                            $findToken->vk_id = $findCheck->change;
                            $findToken->logs = json_encode($decoded_logs,JSON_UNESCAPED_UNICODE + JSON_UNESCAPED_SLASHES);
                            $time_cookie = time();
                            $auth_token = sha1($findToken->login) . '.' . sha1($findToken->email) . '.' . sha1($findToken->vk_id) . '.' . sha1($findToken->password) . '.' . sha1('mini-secret-key' . $time_cookie);
                            $findToken->auth_token = $auth_token;
                            $findToken->expires_time = $time_cookie + 60*60*24*365;
                            R::store($findToken);
                            setcookie('auth.token',$auth_token, $time_cookie + 60*60*24*365, "/", NULL);
                            setcookie('auth.create-time',$time_cookie,$time_cookie + 60*60*24*365, "/", NULL);
                            setcookie('auth.always-sign-in','1',$time_cookie + 60*60*24*365*365, "/", NULL);
                            $vk->SendMessage($findCheck->vk_id,"Ваш ВК был успешно отвязан от вашего аккаунта\n\nИнформация:\n— Логин: " . $findToken->login . "\n— Ник: " . $findToken->nick);
                            $vk->SendMessage($findCheck->change,"Ваш ВК был успешно привязан к вашему аккаунту\n\nИнформация:\n— Логин: " . $findToken->login . "\n— Ник: " . $findToken->nick);
                            $userInfo = $vk->request("users.get", ["user_ids" => $findCheck->change, 'fields' => 'photo_200',"lang" => 'ru']);

                            exit(json_encode(array('error' => 0, 'vk_id' => (int)$findCheck->change, 'avatar' => $userInfo[0]['photo_200']),JSON_UNESCAPED_SLASHES + JSON_UNESCAPED_UNICODE));
                        } else {
                            $core->reportError($core::ERROR_VK_RESERVED,'');
                        }
                        
                    } else {
                        $core->reportError($core::ERROR_TIMEOUT_CODE,'time out');
                    }
                } else {
                    $core->reportError($core::ERROR_BAD_CODE,'Unregistered Code');
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