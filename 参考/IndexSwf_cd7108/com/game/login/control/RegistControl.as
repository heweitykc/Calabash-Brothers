package com.game.login.control
{
    import com.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.manager.resource.*;
    import com.f1.utils.*;
    import com.game.clickstream.*;
    import com.game.login.bean.*;
    import com.game.login.cfg.*;
    import com.game.login.message.*;
    import com.game.login.protocol.*;
    import com.game.login.view.*;
    import com.game.utils.*;
    import com.greensock.*;
    import com.staticdata.*;

    public class RegistControl extends Object
    {
        private var _protocol:RegistProtocol;
        private var registScene:RegistScene;
        private var isCreateRole:Boolean = false;
        private var _rollName:String;
        private var _curJob:uint = 0;
        private var _curSex:uint = 0;
        public var roleCreated:Boolean = false;
        public var createRoleCallback:Function;
        public var loginSuccessHandlerMsg:ResLoginSuccessMessage;
        private var _platRegPanel:PlatRegistPanel;
        private static var instance:RegistControl;
        public static var hasRigister:Boolean = false;

        public function RegistControl()
        {
            this._protocol = new RegistProtocol();
            return;
        }// end function

        public function login() : void
        {
            this._protocol.login();
            return;
        }// end function

        public function platformLogin(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String = null) : void
        {
            this._protocol.platformLogin(param1, param2, param3, param4, param5, param6, param7);
            return;
        }// end function

        public function characterInfoHandler(param1:ResCharacterInfosMessage) : void
        {
            var len:int;
            var i:int;
            var info1:CharacterInfo;
            var msg:* = param1;
            ClickStream.add(ClickStreamId.LOGIN_USER_OK);
            if (msg.characters.length == 0)
            {
                this.isCreateRole = true;
                hasRigister = false;
                if (Params.autoLogin)
                {
                    this.autoRegist();
                    FrameworkGlobal.sendMsg(new GameEvent(GameEvent.REGISTER_PANEL_LOADED));
                }
                else
                {
                    this.registScene = new RegistScene();
                    BasicGlobal.sceneManager.enterScene(this.registScene);
                }
                TweenLite.delayedCall(180, this.auto);
            }
            else
            {
                len = msg.characters.length;
                Log.log("角色个数：" + msg.characters.length);
                if (len > 1)
                {
                    msg.characters.sort(function (param1:CharacterInfo, param2:CharacterInfo) : int
            {
                return param1.level > param2.level ? (-1) : (1);
            }// end function
            );
                }
                i;
                while (i < len)
                {
                    
                    Log.log("角色ID：" + msg.characters[i].playerId + "     角色等级：" + msg.characters[i].level);
                    i = (i + 1);
                }
                info1 = msg.characters[0];
                if (info1)
                {
                    this.selectRole(info1.playerId);
                }
                else
                {
                    this.registScene.simpleTip(LanguageCfgObj.getInstance().getByLoginIndex("1014"));
                }
                FrameworkGlobal.sendMsg(new GameEvent(GameEvent.REGISTER_PANEL_LOADED));
            }
            ServerTime.getInstance().start();
            return;
        }// end function

        private function auto() : void
        {
            Params.autoLogin = true;
            if (!hasRigister)
            {
                this.autoRegist();
            }
            return;
        }// end function

        public function checkNick(param1:String) : void
        {
            return;
        }// end function

        private function autoRegist() : void
        {
            var _loc_2:* = 0;
            if (this._curJob == 0)
            {
                _loc_2 = Math.random() * 10 % 3;
                this._curJob = _loc_2 + 1;
                _loc_2 = Math.random() * 10 % 2;
                this._curSex = _loc_2 + 1;
            }
            if (this._rollName)
            {
                this._rollName = this._rollName + int(Math.random() * 10 % 2 + 1).toString();
            }
            else
            {
                this._rollName = NameCfgObj.getInstance().getRandName(this._curSex);
            }
            var _loc_1:* = ToolKit.checkRoleName(this._rollName);
            if (_loc_1.length == 0)
            {
                this.createRole(this._rollName, this._curSex, this._curJob);
            }
            return;
        }// end function

        public function selectRole(param1:long) : void
        {
            this._protocol.selectRole(param1);
            return;
        }// end function

        public function createRole(param1:String, param2:int, param3:int) : void
        {
            if (param3 == 1)
            {
                PreVResManager.add(PreVResManager.PRE_REGITE, [Params.ROLE_RES_PATH + "sm001/act01/0.png", Params.ROLE_RES_PATH + "sm001/act01/45.png", Params.ROLE_RES_PATH + "sm001/act01/90.png", Params.ROLE_RES_PATH + "sm001/act01/135.png", Params.ROLE_RES_PATH + "sm001/act01/180.png", Params.ROLE_RES_PATH + "sm001/act03/0.png", Params.ROLE_RES_PATH + "sm001/act03/45.png", Params.ROLE_RES_PATH + "sm001/act03/90.png", Params.ROLE_RES_PATH + "sm001/act03/135.png", Params.ROLE_RES_PATH + "sm001/act03/180.png"], 11);
            }
            else if (param3 == 2)
            {
                PreVResManager.add(PreVResManager.PRE_REGITE, [Params.ROLE_RES_PATH + "mg001/act01/0.png", Params.ROLE_RES_PATH + "mg001/act01/45.png", Params.ROLE_RES_PATH + "mg001/act01/90.png", Params.ROLE_RES_PATH + "mg001/act01/135.png", Params.ROLE_RES_PATH + "mg001/act01/180.png", Params.ROLE_RES_PATH + "mg001/act03/0.png", Params.ROLE_RES_PATH + "mg001/act03/45.png", Params.ROLE_RES_PATH + "mg001/act03/90.png", Params.ROLE_RES_PATH + "mg001/act03/135.png", Params.ROLE_RES_PATH + "mg001/act03/180.png"], 11);
            }
            else if (param3 == 3)
            {
                PreVResManager.add(PreVResManager.PRE_REGITE, [Params.ROLE_RES_PATH + "ac001/act01/0.png", Params.ROLE_RES_PATH + "ac001/act01/45.png", Params.ROLE_RES_PATH + "ac001/act01/90.png", Params.ROLE_RES_PATH + "ac001/act01/135.png", Params.ROLE_RES_PATH + "ac001/act01/180.png", Params.ROLE_RES_PATH + "ac001/act03/0.png", Params.ROLE_RES_PATH + "ac001/act03/45.png", Params.ROLE_RES_PATH + "ac001/act03/90.png", Params.ROLE_RES_PATH + "ac001/act03/135.png", Params.ROLE_RES_PATH + "ac001/act03/180.png"], 11);
            }
            PreVResManager.load(PreVResManager.PRE_REGITE);
            this._curJob = param3;
            this._protocol.createRole(param1, param2, param3);
            return;
        }// end function

        public function createRoleSuccessHandler(param1:ResRolesCreateReportToGateMessage) : void
        {
            return;
        }// end function

        public function createRoleFailHandler(param1:ResCreateFailedMessage) : void
        {
            var _loc_2:* = LoginErrorObjCfg.getInstance().getTableFromIDType(param1.reason, 2);
            if (_loc_2)
            {
                if (Params.autoLogin)
                {
                    TweenLite.delayedCall(1.2, this.autoRegist);
                }
                else if (RegistScene.isRandom)
                {
                    TweenLite.delayedCall(1.2, this.autoRegist);
                }
                else
                {
                    RegistScene.hanReturn = true;
                    this.registScene.simpleTip(_loc_2.msg);
                }
            }
            else
            {
                this.registScene.simpleTip(LanguageCfgObj.getInstance().getByLoginIndex("1015"));
            }
            return;
        }// end function

        public function loginSuccessHandler(param1:ResLoginSuccessMessage) : void
        {
            ClickStream.add(ClickStreamId.LOGIN_PLAYER_OK);
            RegistScene.isRegisteSuccess = true;
            RegistScene.hanReturn = true;
            if (this.isCreateRole)
            {
                this.roleCreated = true;
                if (this.createRoleCallback != null)
                {
                    this.createRoleCallback();
                }
            }
            this.loginSuccessHandlerMsg = param1;
            FrameworkGlobal.sendMsg(new GameEvent(GameEvent.LOGIN_SUCCESS));
            ServerTime.getInstance().start();
            FrameworkGlobal.sendMsg(new GameEvent(GameEvent.REGISTER_PANEL_LOADED));
            return;
        }// end function

        public function loginFailHandler(param1:ResLoginFailedMessage) : void
        {
            var _loc_2:* = LoginErrorObjCfg.getInstance().getTableFromIDType(param1.reason, 1);
            if (_loc_2)
            {
                FrameworkGlobal.sendMsg(new GameEvent(GameEvent.LOGIN_FAIL, _loc_2.msg));
            }
            else
            {
                FrameworkGlobal.sendMsg(new GameEvent(GameEvent.LOGIN_FAIL, LanguageCfgObj.getInstance().getByLoginIndex("1013") + param1.reason));
            }
            if (param1.reason == 3)
            {
                JSTools.callJS("showServerBuzzy");
            }
            return;
        }// end function

        public function disposeRegistScene() : void
        {
            if (this.registScene)
            {
                this.registScene.finalize();
                this.registScene = null;
            }
            return;
        }// end function

        public function heartBeatHandler(param1:ResHeartMessage) : void
        {
            ServerTime.getInstance().heartBeatHandler(param1);
            return;
        }// end function

        public function openPlatRegistPanel() : void
        {
            if (!this._platRegPanel)
            {
                this._platRegPanel = new PlatRegistPanel();
                BasicGlobal.popManager.addPop(this._platRegPanel, true, true);
            }
            this._platRegPanel.open();
            return;
        }// end function

        public function substituteHandler(param1:ResSubstituteMessage) : void
        {
            var msg:* = param1;
            FrameworkGlobal.substituted = true;
            BasicGlobal.usePopManager(function () : void
            {
                BasicGlobal.popManager.cue(LanguageCfgObj.getInstance().getByLoginIndex("1016"), LanguageCfgObj.getInstance().getByLoginIndex("1021"), null, function () : void
                {
                    JSTools.openWindow(Params.officialWebSite, "_self");
                    return;
                }// end function
                , null, 1, LanguageCfgObj.getInstance().getByLoginIndex("1020"), false, false, null, false);
                BasicGlobal.popManager.addBgMask(false, true);
                return;
            }// end function
            );
            return;
        }// end function

        public static function getInstance() : RegistControl
        {
            if (instance == null)
            {
                instance = new RegistControl;
            }
            return instance;
        }// end function

    }
}
