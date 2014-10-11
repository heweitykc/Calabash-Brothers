package com.game.challenge.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.challenge.bean.*;
    import com.game.challenge.model.*;
    import com.game.challenge.procotol.*;
    import com.game.challenge.view.*;
    import com.game.guide.model.*;
    import com.game.player.view.*;
    import com.view.tipcell.*;
    import flash.display.*;

    public class BossGuideControl extends Object
    {
        private var _procotol:BossGuideProcotol;
        private var _event:Vector.<BossEventInfo>;
        private var _bossInfo:BossInfo;
        private var _bossGuildPanel:BossGuidePanel;
        private static var _instance:BossGuideControl;

        public function BossGuideControl()
        {
            this._procotol = new BossGuideProcotol();
            this._bossInfo = new BossInfo();
            return;
        }// end function

        public function openOrCloseBossGuildPanel() : void
        {
            if (!GuideConfigObj.getInstance().isOpenFunction(GuideConfigObj.getInstance().BOSSGUILD_ACTIVE_TEAM))
            {
                return;
            }
            if (!this._bossGuildPanel)
            {
                this._bossGuildPanel = new BossGuidePanel();
                Global.popManager.addPop(this._bossGuildPanel);
            }
            this._bossGuildPanel.openOrClose();
            return;
        }// end function

        public function reqSelectChallengeToGame(param1:int) : void
        {
            this._procotol.reqSelectChallengeToGame(param1);
            return;
        }// end function

        public function get event() : Vector.<BossEventInfo>
        {
            return this._event;
        }// end function

        public function set event(param1:Vector.<BossEventInfo>) : void
        {
            this._event = param1;
            return;
        }// end function

        public function get bossInfo() : BossInfo
        {
            return this._bossInfo;
        }// end function

        public function createBossTips(param1:DisplayObject, param2:int = 310180001) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = NaN;
            var _loc_15:* = null;
            var _loc_16:* = 0;
            if (this._bossInfo)
            {
                _loc_3 = this._bossInfo.config;
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    if (_loc_3[_loc_4].q_monsterid == param2)
                    {
                        _loc_6 = _loc_4 + 1;
                        _loc_7 = _loc_3[_loc_4];
                        _loc_8 = QSceneMonsterAreaBeanCfgObj.getInstance().getMonsterByModelIdAndMapId(_loc_7.q_monsterid, _loc_7.q_map);
                        _loc_9 = "";
                        _loc_10 = this.bossInfo.bossLogs[++_loc_4 - 1];
                        if (!_loc_10)
                        {
                            _loc_11 = new Vector.<BossKillEventInfo>;
                        }
                        else
                        {
                            _loc_11 = (this.bossInfo.bossLogs[(_loc_5 - 1)] as BossKillInfo).events;
                        }
                        _loc_12 = _loc_11.length;
                        if (_loc_12 == 0 || _loc_10.isDead == 0)
                        {
                            _loc_14 = 0;
                        }
                        else
                        {
                            _loc_14 = _loc_8.q_relive - (this.bossInfo.serverTime - (_loc_11[(_loc_11.length - 1)] as BossKillEventInfo).touchTime.toNumber()) / 1000;
                        }
                        if (_loc_14 <= 0)
                        {
                            _loc_15 = LanguageCfgObj.getInstance().getByIndex("10432");
                        }
                        else
                        {
                            _loc_15 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11948"), [Math.ceil(_loc_14 / 60)]);
                        }
                        _loc_16 = 0;
                        while (_loc_16 < _loc_12)
                        {
                            
                            _loc_13 = _loc_11[_loc_16];
                            _loc_9 = _loc_9 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11949"), [ToolKit.getTimeBySecond2(_loc_13.touchTime.toNumber() / 1000), _loc_13.playerName]);
                            _loc_16++;
                        }
                        ItemTips.create(param1, {config:_loc_7, frame:_loc_5, hitLog:_loc_9, freshtime:_loc_15}, ChangeJobBossTips);
                        return;
                    }
                    _loc_4++;
                }
            }
            return;
        }// end function

        public static function getInstance() : BossGuideControl
        {
            if (!_instance)
            {
                _instance = new BossGuideControl;
            }
            return _instance;
        }// end function

    }
}
