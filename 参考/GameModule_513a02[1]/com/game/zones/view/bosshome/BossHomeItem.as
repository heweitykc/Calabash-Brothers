package com.game.zones.view.bosshome
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.game.challenge.bean.*;
    import com.game.challenge.model.*;
    import com.game.zones.view.bosshome.cfg.*;
    import com.model.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;

    public class BossHomeItem extends Component
    {
        private var _bossNameTxt:TextField;
        private var _timingTxt:TextField;
        private var _config:QMonsterBossQcfg;
        private var _qsceneMonsterAreaBean:QSceneMonsterAreaBean;
        private var _index:int;
        private var _frame:int;
        private var _goToBtnMc:MovieClip;
        private var _bgMc:MovieClip;
        public var remainTime:Number;
        private static var enableFilter:ColorMatrixFilter = new ColorMatrixFilter(ColorFilter.saturationPer(-90));

        public function BossHomeItem(param1 = null, param2 = null)
        {
            super(param1, param2);
            this.initUI();
            this.addlistener();
            return;
        }// end function

        public function setConfig(param1:int, param2:QMonsterBossQcfg, param3:int) : void
        {
            this._index = param1;
            this._config = param2;
            this._frame = param3;
            this._qsceneMonsterAreaBean = QSceneMonsterAreaBeanCfgObj.getInstance().getMonsterByModelIdAndMapId(this._config.q_monsterid, this._config.q_map);
            this._goToBtnMc.gotoAndStop(param3);
            var _loc_4:* = MonsterCfgObj.getInstance().getMonsterObjCfg(this._config.q_monsterid);
            this._bossNameTxt.htmlText = "<font color = \'#ff9900\'>" + _loc_4.q_name + "</font>";
            return;
        }// end function

        private function addlistener() : void
        {
            addEvtListener(MouseEvent.ROLL_OVER, this.__focus);
            addEvtListener(MouseEvent.ROLL_OUT, this.__cancelfocus);
            return;
        }// end function

        public function updateInfo(param1:BossInfo) : void
        {
            var _loc_3:* = null;
            var _loc_6:* = null;
            Ticker.killTimer(this.__updateTime);
            var _loc_2:* = param1.bossLogs[this._index];
            if (!_loc_2)
            {
                _loc_3 = new Vector.<BossKillEventInfo>;
            }
            else
            {
                _loc_3 = (param1.bossLogs[this._index] as BossKillInfo).events;
            }
            var _loc_4:* = _loc_3.length;
            var _loc_5:* = "";
            if (_loc_4 == 0 || _loc_2.isDead == 0)
            {
                this.remainTime = 0;
            }
            else
            {
                this.remainTime = this._qsceneMonsterAreaBean.q_relive - (param1.serverTime - (_loc_3[(_loc_3.length - 1)] as BossKillEventInfo).touchTime.toNumber()) / 1000;
                Ticker.registerTimer(1, this.__updateTime);
            }
            if (this.remainTime <= 0)
            {
                this._timingTxt.text = LanguageCfgObj.getInstance().getByIndex("10437");
                this._timingTxt.visible = false;
                this.enabled = true;
            }
            else
            {
                this._timingTxt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11948"), [Math.ceil(this.remainTime / 60)]);
                this._timingTxt.visible = true;
                this.enabled = false;
            }
            var _loc_7:* = 0;
            while (_loc_7 < _loc_4)
            {
                
                _loc_6 = _loc_3[_loc_7];
                _loc_5 = _loc_5 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11949"), [ToolKit.getTimeBySecond2(_loc_6.touchTime.toNumber() / 1000), _loc_6.playerName]) + "<br/>");
                _loc_7++;
            }
            var _loc_8:* = BossHomeCfgObj.getInstance().getAngelByModelId(this._config.q_monsterid);
            ItemTips.create(this, {config:this._config, frame:this._frame, hitLog:_loc_5, freshtime:this._timingTxt, anger:_loc_8}, BossHomeItemTips);
            var _loc_9:* = UserObj.getInstance().playerInfo.level;
            var _loc_10:* = MonsterCfgObj.getInstance().getMonsterObjCfg(this._config.q_monsterid);
            var _loc_11:* = GlobalCfgObj.getInstance().getMousterLevel4();
            return;
        }// end function

        private function initUI() : void
        {
            this._goToBtnMc = getDisplayChildByName("goToBtnMc") as MovieClip;
            this._goToBtnMc.mouseEnabled = false;
            this._goToBtnMc.mouseChildren = false;
            this._goToBtnMc.stop();
            this._bgMc = getDisplayChildByName("bgMc");
            this._bgMc.stop();
            this._bossNameTxt = getDisplayChildByName("bossNameTxt");
            this._timingTxt = getDisplayChildByName("timingTxt");
            return;
        }// end function

        private function __updateTime() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this.remainTime - 1;
            _loc_1.remainTime = _loc_2;
            if (this.remainTime <= 0)
            {
                Ticker.killTimer(this.__updateTime);
                this._timingTxt.text = LanguageCfgObj.getInstance().getByIndex("10437");
                this.enabled = true;
                this._timingTxt.visible = false;
            }
            else
            {
                this._timingTxt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11948"), [Math.ceil(this.remainTime / 60)]);
                this.enabled = false;
                this._timingTxt.visible = true;
            }
            return;
        }// end function

        private function __focus(event:MouseEvent) : void
        {
            var _loc_2:* = new GlowFilter(16773120, 0.8, 10, 10, 1, 20);
            this._bgMc.filters = [_loc_2];
            this._goToBtnMc.y = -10;
            this._timingTxt.y = this._timingTxt.y - 10;
            this._bossNameTxt.y = this._bossNameTxt.y - 10;
            this._bgMc.gotoAndStop(2);
            return;
        }// end function

        private function __cancelfocus(event:MouseEvent) : void
        {
            this._bgMc.filters = null;
            this._goToBtnMc.y = 0;
            this._timingTxt.y = this._timingTxt.y + 10;
            this._bossNameTxt.y = this._bossNameTxt.y + 10;
            this._bgMc.gotoAndStop(1);
            return;
        }// end function

        public function set enabled(param1:Boolean) : void
        {
            var _loc_2:* = null;
            if (this._config)
            {
                _loc_2 = MonsterCfgObj.getInstance().getMonsterObjCfg(this._config.q_monsterid);
                if (param1)
                {
                    this.filters = null;
                    this._bossNameTxt.htmlText = "<font color = \'#ff9900\'>" + _loc_2.q_name + "</font>";
                }
                else
                {
                    this._bossNameTxt.htmlText = "<font color = \'#00be12\'>" + _loc_2.q_name + "</font>";
                    this.filters = [enableFilter];
                }
            }
            return;
        }// end function

    }
}
